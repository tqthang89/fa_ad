using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web.UI;

namespace SMI.DAUltility.Reflection
{
    /// <summary>
    /// this method use to generate object understandable delegate "compare"
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class CSort<T> : IComparer, IComparer<T>
    {
        public string mProperty;
        public SortCondition mSortCondition;

        public compare ApplySortCondition(string property, SortCondition sortcondition)
        {
            //TODO: return anonymous delegate 
            //like return new delegate (object value,object value){return ((IComparer)value).compare(value);}
            mProperty = property;
            mSortCondition = sortcondition;
            return delegate(object x, object y)
            {
                return Current.Compare(x, y);
            };
        }

        public int Compare(T x, T y)
        {
            return Compare((object)x, (object)y);
        }

        public int Compare(object x, object y)
        {
            object valuex, valuey;
            valuex = x == null ? null : DataBinder.Eval(x, mProperty);
            valuey = y == null ? null : DataBinder.Eval(y, mProperty);
            int returnValue;
            if (valuex == null && valuey == null)
                returnValue = 0;
            else if (valuex == null)
                returnValue = -1;
            else if (valuey == null)
                returnValue = 1;
            else
            {
                if (valuex is IComparable) returnValue = ((IComparable)valuex).CompareTo(valuey);
                else if (valuey is IComparable) returnValue = -1 * (((IComparable)valuey).CompareTo(valuex));
                else throw new Exception("both valuex and value y is not implement IComparable");
            }
            return returnValue * (int)mSortCondition;
        }

        #region singleton

        private static CSort<T> sCurrent = null;
        public static CSort<T> Current
        {
            get { return sCurrent ?? (sCurrent = new CSort<T>()); }
        }

        #endregion

        public static T GetValue(object value, string propertyName, T defaultValue)
        {
            if (value == null)
                return defaultValue;
            object __temp = DataBinder.Eval(value, propertyName);
            if (__temp == null || __temp == DBNull.Value || __temp is T)
                return ((__temp == null || __temp == DBNull.Value) ? defaultValue : ((T)__temp));
            return CConvert.Current.ConvertTo<T>(__temp, null);
        }

        public static T GetStaticValue(Type type, string propertyName, T defaultValue)
        {
            try
            {
                return (T)type.GetProperty(propertyName).GetValue(null, null);
            }
            catch (Exception)
            {
                return defaultValue;
            }
        }

        public static object SetValue(object pObject, string propertyName, T value)
        {
            if (pObject == null) return null;
            PropertyInfo __temp;
            if ((__temp = pObject.GetType().GetProperty(propertyName)) == null
               || !__temp.CanWrite)
                return null;
            try
            {
                __temp.SetValue(pObject, value, null);
                return value;
            }
            catch
            {
                return null;
            }
        }

        public T Recursive(T value, string propertyName, T defaultValue, compare compare)
        {
            if (Equals(value, default(T)))
                return default(T);
            T _temps = GetValue(value, propertyName, default(T));
            if (Equals(_temps, default(T)))
                return default(T);
            if (compare(value, _temps) == 0)
                return defaultValue;
            return Recursive(_temps, propertyName, defaultValue, compare);
        }

        public static Type GetType(string typeName)
        {
            Assembly[] _items = AppDomain.CurrentDomain.GetAssemblies();
            if (_items == null || _items.Length <= 0)
                return null;
            Type returnType = null;
            foreach (Assembly _item in _items)
            {
                if ((returnType = _item.GetType(typeName)) != null)
                    break;
            }
            return returnType;
        }
    }

    public enum SortCondition : int
    {
        asc = -1, desc = 1
    }
}