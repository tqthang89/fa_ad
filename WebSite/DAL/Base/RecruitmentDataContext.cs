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
using Microsoft.ApplicationBlocks.Data;

namespace DAL.Base
{
    [Database]
    public abstract class RecruitmentDataContext : System.Data.Linq.DataContext
    {
        private static System.Data.Linq.Mapping.MappingSource mapping = new System.Data.Linq.Mapping.AttributeMappingSource();

        public RecruitmentDataContext()
            : this(DefaultConnectionString())
        {

        }
        public RecruitmentDataContext(string ConnectionStrings)
            : base(ConnectionStrings, mapping)
        {

        }

        public static String ConnectionString(String Name)
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings[Name].ConnectionString;
        }
        private static int SqlCommandTimeout()
        {
            if (System.Configuration.ConfigurationManager.AppSettings["SqlCommandTimeout"] == null)
                return 180;
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
            return ConnectionString("connStr2");
        }
        public static SqlConnection GetConnection()
        {
            SqlConnection lConn = new SqlConnection(DefaultConnectionString());
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

        public static DataSet ExecuteDataset(string spName, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlDataAdapter da = null;
            DataSet ds = new DataSet("dataSet");
            SqlCommand cmd = null;
            try
            {
                cmd = lConn.CreateCommand();
                cmd.CommandTimeout = SqlCommandTimeout();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                if ((parameterValues != null) && (parameterValues.Length > 0))
                {
                    object[] ps = new object[1 + parameterValues.Length];
                    Array.Copy(parameterValues, 0, ps, 1, parameterValues.Length);
                    SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(DefaultConnectionString(), spName, true);
                    AssignParameterValues(commandParameters, ps);
                    AttachParameters(cmd, commandParameters);

                    ///////win
                    foreach (SqlParameter parameter in cmd.Parameters)
                    {
                        if (parameter.SqlDbType != SqlDbType.Structured)
                        {
                            continue;
                        }
                        string name = parameter.TypeName;
                        int index = name.IndexOf(".");
                        if (index == -1)
                        {
                            continue;
                        }
                        name = name.Substring(index + 1);
                        if (name.Contains("."))
                        {
                            parameter.TypeName = name;
                        }
                    }
                }
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                clearParameters(cmd);
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
            return ds;
        }
        private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
        {
            if ((commandParameters == null) || (parameterValues == null))
            {
                return;
            }

            if (commandParameters.Length != parameterValues.Length)
            {
                throw new ArgumentException("Parameter count does not match Parameter Value count.");
            }

            for (int i = 0, j = commandParameters.Length; i < j; i++)
            {
                if (parameterValues[i] is IDbDataParameter)
                {
                    IDbDataParameter paramInstance = (IDbDataParameter)parameterValues[i];
                    if (paramInstance.Value == null)
                    {
                        commandParameters[i].Value = DBNull.Value;
                    }
                    else
                    {
                        commandParameters[i].Value = paramInstance.Value;
                    }
                }
                else if (parameterValues[i] == null)
                {
                    commandParameters[i].Value = DBNull.Value;
                }
                else
                {
                    commandParameters[i].Value = parameterValues[i];
                }
            }
        }
        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            if (command == null) throw new ArgumentNullException("command");
            if (commandParameters != null)
            {
                foreach (SqlParameter p in commandParameters)
                {
                    if (p != null)
                    {
                        if ((p.Direction == ParameterDirection.InputOutput ||
                             p.Direction == ParameterDirection.Input) &&
                            (p.Value == null))
                        {
                            p.Value = DBNull.Value;
                        }
                        command.Parameters.Add(p);
                    }
                }
            }
        }
        private static void clearParameters(SqlCommand cmd)
        {
            bool canClear = true;
            foreach (SqlParameter commandParameter in cmd.Parameters)
            {
                if (commandParameter.Direction != ParameterDirection.Input)
                    canClear = false;
            }
            if (canClear)
            {
                cmd.Parameters.Clear();
            }
        }
        public static void Fetch(Action<Dictionary<string, object>, Exception> _foreachRow, string spName, params object[] parameterValues)
        {
            SqlConnection lConn = GetConnection();
            SqlDataReader reader = null;
            SqlCommand cmd = null;
            try
            {
                cmd = lConn.CreateCommand();
                cmd.CommandTimeout = SqlCommandTimeout();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                if ((parameterValues != null) && (parameterValues.Length > 0))
                {
                    SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(DefaultConnectionString(), spName, true);
                    AssignParameterValues(commandParameters, parameterValues);
                    AttachParameters(cmd, commandParameters);
                }
                reader = cmd.ExecuteReader();
                clearParameters(cmd);
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
                if (cmd != null)
                    cmd.Dispose();
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

        public static void Fetch<T>(Action<T> _foreachRow, string spName, params object[] parameterValues) where T : class, new()
        {
            Fetch<T>((T row, Exception ex) =>
            {
                _foreachRow.Invoke(row);
            }, spName, parameterValues);
        }


        public static List<T> Fetch<T>(string spName, params object[] parameterValues) where T : class, new()
        {
            List<T> list = new List<T>();
            Fetch<T>(list.Add, spName, parameterValues);
            return list;
        }

        public static void Fetch<T>(Action<T, Exception> _foreachRow, string spName, params object[] parameterValues) where T : class, new()
        {
            SqlConnection lConn = GetConnection();
            SqlDataReader reader = null;
            SqlCommand cmd = null;
            try
            {
                cmd = lConn.CreateCommand();
                cmd.CommandTimeout = SqlCommandTimeout();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                if ((parameterValues != null) && (parameterValues.Length > 0))
                {
                    SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(DefaultConnectionString(), spName, true);
                    AssignParameterValues(commandParameters, parameterValues);
                    AttachParameters(cmd, commandParameters);
                }
                reader = cmd.ExecuteReader();
                clearParameters(cmd);
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
                if (cmd != null)
                    cmd.Dispose();
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
        public static DataSet ExecuteDataset(string connectionName, string spName, params object[] paramValues)
        {
            SqlConnection lConn = GetConnection(connectionName);
            DataSet ds = null;
            try
            {
                ds = SqlHelper.ExecuteDataset(lConn, spName, paramValues);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                }
                catch (Exception)
                {

                }
            }
            return ds;
        }

        public static int ExecuteNonQuery(string spName, params object[] parameterValues)
        {
            int i = 0;
            SqlConnection lConn = GetConnection();
            try
            {
                i = SqlHelper.ExecuteNonQuery(lConn, spName, parameterValues);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                try
                {
                    lConn.Close();
                    lConn.Dispose();
                }
                catch (Exception)
                {

                }
            }
            return i;
        }

        public static int ExecuteNonQuery1(string spName, params object[] parameterValues)
        {
            int i = 0;
            SqlConnection cn = GetConnection();
            SqlTransaction tr = cn.BeginTransaction();
            try
            {
                i = SqlHelper.ExecuteNonQuery(tr, spName, parameterValues);
                tr.Commit();
                tr.Dispose();
            }
            catch (Exception)
            {
                tr.Rollback();
            }
            finally
            {
                cn.Close();
                cn.Dispose();
            }
            return i;
        }
    }
}