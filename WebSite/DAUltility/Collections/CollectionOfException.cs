namespace SMI.DAUltility {
    using System;
    using System.Collections;
    using System.Collections.Generic;

    public class CollectionOfException:Exception,IList<Exception>,IDisposable {
        private List<Exception> innerList=null;

        public CollectionOfException() {
            innerList=new List<Exception>();
        }

        public CollectionOfException(List<Exception> pInnerList) {
            innerList = pInnerList;
        }

        public CollectionOfException(string pMessage) : base(pMessage) {
            innerList=new List<Exception>();
        }


        public CollectionOfException(string pMessage, List<Exception> pInnerList) : base(pMessage) {
            innerList = pInnerList;
        }

        public int IndexOf(Exception item) {
            return innerList.IndexOf(item);
        }

        public void Insert(int index, Exception item) {
            innerList.Insert(index,item);
        }

        public void RemoveAt(int index) {
            innerList.RemoveAt(index);
        }

        public Exception this[int index] {
            get { return innerList[index]; }
            set { innerList[index]=value; }
        }

        public void Add(Exception item) {
            innerList.Add(item);
        }

        public void Clear() {
            innerList.Clear();
        }

        public bool Contains(Exception item) {
            return innerList.Contains(item);
        }

        public void CopyTo(Exception[] array, int arrayIndex) {
            innerList.CopyTo(array,arrayIndex);
        }

        public bool Remove(Exception item) {
            throw new NotImplementedException();
        }

        public int Count {
            get { return innerList.Count; }
        }

        public bool IsReadOnly {
            get { return true; }
        }

        IEnumerator<Exception> IEnumerable<Exception>.GetEnumerator() {
            return innerList.GetEnumerator();
        }

        public IEnumerator GetEnumerator() {
            return innerList.GetEnumerator();
        }

        public void Dispose() {
            GC.ReRegisterForFinalize(innerList);
            innerList=null;
            GC.Collect();
        }
    }
}