using System;
using System.Configuration;
using System.Data;
using System.Data.Common;

namespace SMI.DAUltility.Helpers
{
    public class Helper : IDisposable{
        #region sigleton object

        public static Helper _Current = null;

        public static Helper Current
        {
            get { return _Current; }
            set { _Current = value; }
        }

        #endregion

        public void Dispose() {
            
        }

        private readonly DbProviderFactory _Factory;

        public Helper() {
            ConnectionStringSettingsCollection __temp;
            if ((__temp = ConfigurationManager.ConnectionStrings) == null || __temp.Count <= 0)
                throw new NotImplementedException("Connectionstring must be configure first, the first item will be default");
            _Factory = DbProviderFactories.GetFactory(__temp[0].ProviderName);
        }

        public IDbConnection GetConnection() {
            IDbConnection conn=_Factory.CreateConnection();
            conn.Open();
            return conn;
        }

        public IDbTransaction GetTransaction() {
            return GetConnection().BeginTransaction();
        }

        public IDbTransaction GetTransaction(IsolationLevel level ) {
            return GetConnection().BeginTransaction(level);
        }

        public IDbCommand GetProcedure(IDbTransaction transaction,string procedureName,params DbParameter [] parameters) {
            IDbCommand _command = _Factory.CreateCommand();
            _command.CommandType=CommandType.StoredProcedure;
            _command.Transaction = transaction;
            if(parameters!=null && parameters.Length>0)
                foreach (DbParameter parameter in parameters) 
                    _command.Parameters.Add(parameter);
            return _command;
        }

        public IDbCommand GetProcedure(IDbConnection connection, string procedureName, params DbParameter[] parameters)
        {
            IDbCommand _command = _Factory.CreateCommand();
            _command.CommandType = CommandType.StoredProcedure;
            _command.Connection= connection;
            if (parameters != null && parameters.Length > 0)
                foreach (DbParameter parameter in parameters)
                    _command.Parameters.Add(parameter);
            return _command;
        }

        public IDbCommand GetCommand(IDbTransaction transaction, string sql, params DbParameter[] parameters)
        {
            IDbCommand _command = _Factory.CreateCommand();
            _command.CommandType = CommandType.Text;
            _command.Transaction = transaction;
            if (parameters != null && parameters.Length > 0)
                foreach (DbParameter parameter in parameters)
                    _command.Parameters.Add(parameter);
            return _command;
        }

        public IDbCommand GetCommand(IDbConnection connection, string sql, params DbParameter[] parameters)
        {
            IDbCommand _command = _Factory.CreateCommand();
            _command.CommandType = CommandType.Text;
            _command.Connection = connection;
            if (parameters != null && parameters.Length > 0)
                foreach (DbParameter parameter in parameters)
                    _command.Parameters.Add(parameter);
            return _command;
        }
        
    }
}
