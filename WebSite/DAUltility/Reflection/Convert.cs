using System.Collections.Specialized;
using System.Reflection;

namespace SMI.DAUltility.Reflection
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Web.UI;

    public class CConvert
    {

        public IList ConvertTo(Type from, Type destination, IList value, IList returnValue)
        {
            IList _returnValue = returnValue ?? new ArrayList();
            TypeConverter fromConverter = TypeDescriptor.GetConverter(from);
            if (fromConverter != null && fromConverter.CanConvertTo(destination))
            {
                foreach (object _object in value)
                {
                    object _o = fromConverter.ConvertTo(_object, destination);
                    if (_o != null)
                        _returnValue.Add(_o);
                }
                return _returnValue;
            }
            TypeConverter destinationConverter = TypeDescriptor.GetConverter(destination);
            if (destinationConverter != null && destinationConverter.CanConvertFrom(from))
            {
                foreach (object _object in value)
                {
                    object _o = destinationConverter.ConvertFrom(_object);
                    if (_o != null)
                        _returnValue.Add(_o);
                }
                return _returnValue;
            }
            throw new NotSupportedException();
        }

        public IList ConvertTo(Type from, Type destination, IList value)
        {
            return ConvertTo(from, destination, value, null);
        }

        public ReturnType[] ConvertTo<ReturnType>(Type from, Type destination, IList value)
        {
            ArrayList _list = (ArrayList)ConvertTo(from, destination, value, null);
            return (ReturnType[])_list.ToArray(typeof(ReturnType));
        }

        //AND
        /// <summary>
        ///    perform find each item in itemA in itemB by using comparer
        /// </summary>
        /// <param name="itemA">Main Object, return object in itemA</param>
        /// <returns>item in ItemA that match in itemB by compare return 0</returns>

        public IList AND(IList itemA, IList itemB, compare pCompare)
        {
            IList retList = new ArrayList();
            if (pCompare == null)
            {
                foreach (object lObjInA in itemA)
                {
                    foreach (object lObjInB in itemB)
                    {
                        if (lObjInA.Equals(lObjInB))
                        {
                            retList.Add(lObjInA);
                            break;
                        }
                    }

                }
            }
            else
            {
                foreach (object lObjInA in itemA)
                {
                    foreach (object lObjInB in itemB)
                    {
                        if (pCompare(lObjInA, lObjInB) == 0)
                        {
                            retList.Add(lObjInA);
                            break;
                        }
                    }

                }
            }

            return retList;
        }
        //OR
        public IList OR(IList itemA, IList itemB, compare pCompare)
        {
            IList retList = new ArrayList();
            if (pCompare == null)
            {
                foreach (object lObjInA in itemA)
                {
                    foreach (object lObjInB in itemB)
                    {
                        if (!lObjInA.Equals(lObjInB))
                        {
                            retList.Add(lObjInA);
                            break;
                        }
                    }

                }
            }
            else
            {
                foreach (object lObjInA in itemA)
                {
                    foreach (object lObjInB in itemB)
                    {
                        if (pCompare(lObjInA, lObjInB) != 0)
                        {
                            retList.Add(lObjInA);
                            break;
                        }
                    }

                }
            }

            return retList;
        }
        //TOARRAY: 
        /// <summary>
        /// 
        /// </summary>
        /// <param name="itemA"></param>
        /// <param name="propertyName"></param>
        /// <returns></returns>
        public IList ToArray(ICollection itemA, string propertyName)
        {
            return ToArray<ArrayList, object>(itemA, propertyName);
        }

        public T ToArray<T, TDetail>(ICollection itemA, string propertyName) where T : IList, new()
        {
            T list = new T();
            TDetail value;
            foreach (object lObject in itemA)
            {
                object _tempValue = DataBinder.Eval(lObject, propertyName);
                if (_tempValue != null && _tempValue is TDetail)
                {
                    list.Add(_tempValue);
                }
                //                if((value=(_tempValue=DataBinder.Eval(lObject,propertyName)) )!=null) {
                //                    list.Add(value);
                //                }
            }
            return list;
        }

        public T FindAll<T, TDetail>(ICollection items, Predicate<TDetail> compare) where T : IList, new()
        {
            T returnValue = new T();
            foreach (TDetail lItem in items)
            {
                if (compare(lItem))
                    returnValue.Add(lItem);
            }
            return returnValue;
        }

        public T Find<T>(IList items, match compare)
        {
            if (items == null || items.Count <= 0)
                goto end;
            for (int i = items.Count - 1; i >= 0; i--)
            {
                object __temps;
                if (compare(__temps = items[i]))
                    return (T)__temps;
            }
        end:
            return default(T);
        }

        public string GetTableName<TSystemName>()
        {
            return typeof(TSystemName).Name;
        }

        private static CConvert sCurrent = null;

        public static CConvert Current
        {
            get { return sCurrent ?? (sCurrent = new CConvert()); }
        }

        public string ToCapitialize(string value, params char[] seperators)
        {
            string[] _source;
            if (seperators == null || seperators.Length <= 0)
                _source = new string[] { value.Trim().Replace("  ", " ") };
            else
                _source = value.Trim().Replace("  ", " ").Split(seperators);
            List<string> _factory = new List<string>(_source);
            for (int i = 0; i < _factory.Count; i++)
            {
                string __temp;
                if ((__temp = _factory[i]).Length > 1)
                    _factory[i] = string.Concat(__temp.Substring(0, 1).ToUpper(), __temp.Substring(1));
            }
            return string.Join(" ", _factory.ToArray());
        }

        public string Format(string formatstring, object value)
        {
            if (formatstring == null || formatstring == string.Empty || value == null) return formatstring;
            if (value is ValueType)
                return string.Format(formatstring, value);
            //else
            PropertyInfo[] __properties = value.GetType().GetProperties();
            if (__properties == null || __properties.Length <= 0)
                return string.Empty;
            foreach (PropertyInfo info in __properties)
            {
                object __tempValue = info.GetValue(value, null);
                formatstring = formatstring.Replace("{" + info.Name + "}", Convert.ToString(__tempValue));
            }
            return formatstring;
        }

        public T ConvertTo<T>(object value, Type destinationType)
        {
            try
            {
                return (T)TypeDescriptor.GetConverter(value).ConvertTo(value, destinationType ?? typeof(T));
            }
            catch (Exception)
            {
                try
                {
                    return (T)TypeDescriptor.GetConverter(destinationType ?? typeof(T)).ConvertFrom(value);
                }
                catch (Exception)
                {
                    return default(T);
                }
            }
        }

        public object CopyTo(object from, object destination)
        {
            PropertyInfo[]
                _sources =
                    from.GetType().GetProperties(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance),
                _destinations =
                    destination.GetType().GetProperties(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);
            foreach (PropertyInfo __source in _sources)
                foreach (PropertyInfo __destination in _destinations)
                {
                    try
                    {
                        if (__source.Name.Equals(__destination.Name))
                            __destination.SetValue(destination, __source.GetValue(from, null), null);
                    }
#pragma warning disable EmptyGeneralCatchClause
                    catch { }
#pragma warning restore EmptyGeneralCatchClause
                }
            return destination;
        }

        public void SetValue(IEnumerable records, string Expression, object id)
        {
            if (records == null)
                return;
            foreach (object record in records)
                if (record != null)
                    CSort<object>.SetValue(record, Expression, id);
        }

        public object CopyTo(IDictionary from, object value)
        {
            Type DescType = value.GetType();
            foreach (DictionaryEntry entry in from)
            {
                PropertyInfo _proInfo = DescType.GetProperty((string)entry.Key);
                if (_proInfo != null)
                    _proInfo.SetValue(value, entry.Value, null);
            }
            return value;
        }
    }

    public delegate int compare(object a, object b);
    public delegate int comparable(object value);
    public delegate bool match(object value);
}