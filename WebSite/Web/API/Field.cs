using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECS_Web.API
{
    public class Field
    {
        private string value;

        public virtual string Value
        {
            get { return this.value; }
            set { this.value = value; }
        }
        private string name;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        private string format;

        public string Format
        {
            get { return format; }
            set { format = value; }
        }
        private Exception error;
        public Exception Error
        {
            get { return error; }
            set { error = value; }
        }
        public Field()
        {

        }
        public Field(string name)
        {
            this.name = name;
        }
        public Field(string name, string value)
        {
            this.name = name;
            this.value = value;
        }

        public static implicit operator int?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToInt32(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator long?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToInt32(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator float?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToSingle(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator short?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToInt16(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator decimal?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToDecimal(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator double?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return Convert.ToDouble(value.Value);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator string(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return value.Value;
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator DateTime?(Field value)
        {
            if (value == null)
                return null;
            if (string.IsNullOrEmpty(value.Value))
                return null;
            try
            {
                return DateTime.ParseExact(value.Value, value.format, null);
            }
            catch (Exception e)
            {
                value.error = e;
            }
            return null;
        }
        public static implicit operator bool(Field value)
        {
            if (value == null)
                return false;
            if (string.IsNullOrEmpty(value.Value))
                return false;
            return string.Equals(value.Value, "yes", StringComparison.CurrentCultureIgnoreCase)
                || string.Equals(value.Value, "on", StringComparison.CurrentCultureIgnoreCase)
                || string.Equals(value.Value, "true", StringComparison.CurrentCultureIgnoreCase)
                || string.Equals(value.Value, "1", StringComparison.CurrentCultureIgnoreCase);
        }
    }
}