using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data;
using System.Reflection;
using System.Data.Linq;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Security.Cryptography;
using System.Text;

namespace DAL.Base
{
    [Database]
    public abstract class MyDataContext : System.Data.Linq.DataContext
    {
        public string UniqueId(int maxSize = 10)
        {
            char[] chars = new char[36];
            string a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz";
            chars = a.ToCharArray();
            int size = maxSize;
            byte[] data = new byte[1];
            RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
            crypto.GetNonZeroBytes(data);
            size = maxSize;
            data = new byte[size];
            crypto.GetNonZeroBytes(data);
            StringBuilder result = new StringBuilder(size);
            foreach (byte b in data)
            {
                result.Append(chars[b % (chars.Length - 1)]);
            }
            return result.ToString();
        }
        private static System.Data.Linq.Mapping.MappingSource mapping = new System.Data.Linq.Mapping.AttributeMappingSource();

        public MyDataContext()
            : this(DefaultConnectionString())
        {

        }
        public MyDataContext(string ConnectionStrings)
            : base(ConnectionStrings, mapping)
        {
            this.CommandTimeout = SqlCommandTimeout();
        }

        public static String ConnectionString(String Name)
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings[Name].ConnectionString;
        }
        private static int SqlCommandTimeout()
        {
            if (System.Configuration.ConfigurationManager.AppSettings["SqlCommandTimeout"] == null)
                return 600;
            try
            {
                return Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["SqlCommandTimeout"]);
            }
            catch (Exception e)
            {
                throw new Exception("SqlCommandTimeout", e);
            }
        }
        public static String DefaultConnectionString()
        {
            return ConnectionString("ConnStr");
        }
        public static SqlConnection GetConnection()
        {
            SqlConnection lConn = new SqlConnection(DefaultConnectionString());
            if (lConn.State == ConnectionState.Closed)
                lConn.Open();
            return lConn;
        }
        /// <summary>
        /// use for test unit purpose
        /// </summary>
        public static SqlConnection GetConnection(String Name)
        {
            SqlConnection lConn = new SqlConnection(ConnectionString(Name));
            lConn.Open();
            return lConn;
        }

        public void Fetch(Action<Dictionary<string, object>, Exception> _foreachRow, MethodInfo methed, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlDataReader reader = null;
            try
            {
                reader = ExecuteReader(ref lConn, methed, parameterValues);
                while (!reader.IsClosed && reader.Read())
                {
                    Dictionary<string, object> row = new Dictionary<string, object>();
                    Exception error = null;
                    try
                    {
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            var fieldName = reader.GetName(i);
                            var value = reader.GetValue(i);
                            row.Add(fieldName, value);
                        }
                    }
                    catch (Exception ex)
                    {
                        error = ex;
                    }
                    _foreachRow.Invoke(row, error);
                    row.Clear();
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                try
                {
                    reader.Close();
                    reader.Dispose();
                    reader = null;
                }
                catch (Exception)
                {

                }
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }
        }

        public void Fetch<T>(Action<T> _foreachRow, MethodInfo methed, params object[] parameterValues) where T : class, new()
        {
            Fetch<T>((T row, Exception ex) =>
            {
                _foreachRow.Invoke(row);
            }, methed, parameterValues);
        }


        public List<T> Fetch<T>(MethodInfo methed, params object[] parameterValues) where T : class, new()
        {
            List<T> list = new List<T>();
            Fetch<T>(list.Add, methed, parameterValues);
            return list;
        }

        public void Fetch<T>(Action<T, Exception> _foreachRow, MethodInfo methed, params object[] parameterValues) where T : class, new()
        {
            SqlConnection lConn = GetConnection();
            SqlDataReader reader = null;
            try
            {

                reader = ExecuteReader(ref lConn, methed, parameterValues);
                while (!reader.IsClosed && reader.Read())
                {
                    T row = Activator.CreateInstance<T>();
                    Exception error = null;
                    try
                    {
                        PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));
                        foreach (PropertyDescriptor item in props)
                        {
                            if (item.IsReadOnly)
                                continue;
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                if (item.Name.Equals(reader.GetName(i), StringComparison.OrdinalIgnoreCase))
                                {
                                    item.SetValue(row, reader.GetValue(i));
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        error = ex;
                    }
                    _foreachRow.Invoke(row, error);
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                try
                {
                    reader.Close();
                    reader.Dispose();
                    reader = null;
                }
                catch (Exception)
                {

                }
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }
        }

        public int ExecuteNonQuery(MethodInfo methed, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlCommand cmd = null;
            try
            {
                var Function = methed.GetCustomAttributes(typeof(FunctionAttribute));
                if (Function != null && Function.Count() > 0)
                {
                    var func = (FunctionAttribute)Function.FirstOrDefault();
                    cmd = lConn.CreateCommand();
                    cmd.CommandTimeout = SqlCommandTimeout();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = func.Name;
                    var Parameters = methed.GetParameters();
                    if (Parameters != null && Parameters.Count() != 0)
                    {
                        foreach (var item in Parameters)
                        {
                            var param = item.GetCustomAttribute<ParameterAttribute>();
                            if (param != null)
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = param.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                            else
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = item.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                        }
                    }
                    var returnParameter = cmd.Parameters.Add("@return_value", SqlDbType.Int);
                    returnParameter.Direction = ParameterDirection.Output;
                    var r = cmd.ExecuteNonQuery();
                    if (returnParameter.Value != null)
                    {
                        var i = Convert.ToInt32(returnParameter.Value);
                        if (i != 0)
                            return i;
                    }
                    return r;
                }
                return 0;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (cmd != null)
                    cmd.Dispose();

                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }

        }
        public int ExecuteNonQueryV2(MethodInfo methed, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlCommand cmd = null;
            try
            {
                var Function = methed.GetCustomAttributes(typeof(FunctionAttribute));
                if (Function != null && Function.Count() > 0)
                {
                    var func = (FunctionAttribute)Function.FirstOrDefault();
                    cmd = lConn.CreateCommand();
                    cmd.CommandTimeout = SqlCommandTimeout();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = func.Name;
                    var Parameters = methed.GetParameters();
                    cmd.Parameters.Add("@Value", SqlDbType.Int).Direction = ParameterDirection.Output;
                    if (Parameters != null && Parameters.Count() != 0)
                    {
                        foreach (var item in Parameters)
                        {
                            var param = item.GetCustomAttribute<ParameterAttribute>();
                            if (param != null)
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = param.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                            else
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = item.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                        }
                    }
                    cmd.ExecuteNonQuery();
                    int Value = Convert.ToInt32(cmd.Parameters["@Value"].Value);
                    return Value;
                }
                return 0;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (cmd != null)
                    cmd.Dispose();

                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }

        }
        public DataSet ExecuteDataset(MethodInfo methed, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlCommand cmd = null;
            try
            {
                var Function = methed.GetCustomAttributes(typeof(FunctionAttribute));
                if (Function != null && Function.Count() > 0)
                {
                    var func = (FunctionAttribute)Function.FirstOrDefault();
                    cmd = lConn.CreateCommand();
                    cmd.CommandTimeout = SqlCommandTimeout();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = func.Name;
                    var Parameters = methed.GetParameters();
                    if (Parameters != null && Parameters.Count() != 0)
                    {
                        foreach (var item in Parameters)
                        {
                            var param = item.GetCustomAttribute<ParameterAttribute>();
                            if (param != null)
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = param.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                            else
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = item.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                        }
                    }
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.FillLoadOption = LoadOption.Upsert;
                    da.Fill(ds);
                    cmd.Dispose();
                    lConn.Close();
                    lConn.Dispose();
                    return ds;
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (cmd != null)
                    cmd.Dispose();
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }

        }
        public DataTable ExecuteDatatable(MethodInfo methed, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlCommand cmd = null;
            try
            {
                var Function = methed.GetCustomAttributes(typeof(FunctionAttribute));
                if (Function != null && Function.Count() > 0)
                {
                    var func = (FunctionAttribute)Function.FirstOrDefault();
                    cmd = lConn.CreateCommand();
                    cmd.CommandTimeout = SqlCommandTimeout();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = func.Name;
                    var Parameters = methed.GetParameters();
                    if (Parameters != null && Parameters.Count() != 0)
                    {
                        foreach (var item in Parameters)
                        {
                            var param = item.GetCustomAttribute<ParameterAttribute>();
                            if (param != null)
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = param.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                            else
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = item.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                        }
                    }
                    DataTable ds = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.AcceptChangesDuringFill = false;
                    da.FillLoadOption = LoadOption.Upsert;
                    da.Fill(ds);
                    cmd.Dispose();
                    lConn.Close();
                    lConn.Dispose();
                    return ds;
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                if (cmd != null)
                    cmd.Dispose();
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                    lConn = null;
                }
                catch (Exception)
                {

                }
            }

        }

        protected SqlDataReader ExecuteReader(ref SqlConnection lConn, MethodInfo methed, params object[] parameterValues)
        {
            SqlCommand cmd = null;
            try
            {
                var Function = methed.GetCustomAttributes(typeof(FunctionAttribute));
                if (Function != null && Function.Count() > 0)
                {
                    var func = (FunctionAttribute)Function.FirstOrDefault();
                    cmd = lConn.CreateCommand();
                    cmd.CommandTimeout = SqlCommandTimeout();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = func.Name;
                    var Parameters = methed.GetParameters();
                    if (Parameters != null && Parameters.Count() != 0)
                    {
                        foreach (var item in Parameters)
                        {
                            var param = item.GetCustomAttribute<ParameterAttribute>();
                            if (param != null)
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = param.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                            else
                            {
                                var p = cmd.CreateParameter();
                                p.ParameterName = item.Name;
                                p.Value = parameterValues[item.Position];
                                cmd.Parameters.Add(p);
                            }
                        }
                    }
                    return cmd.ExecuteReader();
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}