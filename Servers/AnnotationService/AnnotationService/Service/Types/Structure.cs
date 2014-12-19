﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.Runtime.Serialization;

using Annotation.Database;

namespace Annotation
{
    [DataContract]
    public class CreateStructureRetval
    {
        private Structure _structure;
        private Location _location;

        [DataMember]
        public Structure structure { get { return _structure; } set { _structure = value; } }

        [DataMember]
        public Location location { get { return _location; } set { _location = value; }  }

        public CreateStructureRetval(Structure s, Location l)
        {
            _structure = s;
            _location = l;
        }

        public CreateStructureRetval()
        {
        }
    }

    [DataContract]
    public class Structure : DataObjectWithParent<long>
    {
        protected long _Type;
        protected string _Notes;
        protected bool _Verified; 
        protected double _Confidence;
        protected StructureLink[] _Links;
        protected long[] _ChildIDs;
        protected string _Label;
        protected string _Username;
        protected string _Xml;
        
        [DataMember]
        public long TypeID
        {
            get { return _Type; }
            set { _Type = value; }
        }

        [DataMember]
        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        [DataMember]
        public bool Verified
        {
            get { return _Verified; }
            set { _Verified = value; }
        }

        /*
        [DataMember]
        public string[] Tags
        {
            get { return _Tags; }
            set { _Tags = value; }
        }
        */

        [DataMember]
        public string AttributesXml
        {
            get { return _Xml; }
            set { _Xml = value; }
        }

        [DataMember]
        public double Confidence
        {
            get { return _Confidence; }
            set { _Confidence = value; }
        }

        [DataMember]
        public StructureLink[] Links
        {
            get { return _Links; }
            set { _Links = value; }
        }

        [DataMember]
        public long[] ChildIDs
        {
            get { return _ChildIDs; }
            set { _ChildIDs = value; }
        }

        [DataMember]
        public string Label
        {
            get { return _Label; }
            set { _Label = value; }
        }

        [DataMember]
        [Column("Username")]
        public string Username
        {
            get { return _Username; }
            set { _Username = value; }
        }

        private static StructureLink[] PopulateLinks(DBStructure db)
        {
            if (!(db.IsSourceOf.Any() || db.IsTargetOf.Any()))
                return null;

            StructureLink[] _Links = new StructureLink[db.IsSourceOf.Count + db.IsTargetOf.Count];

            int i = 0;
            foreach (DBStructureLink link in db.IsSourceOf)
            {
                _Links[i] = new StructureLink(link);
                i++;
            }

            foreach (DBStructureLink link in db.IsTargetOf)
            {
                _Links[i] = new StructureLink(link);
                i++;
            }

            return _Links;
        }

        public Structure()
        {
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="IncludeChildren">Include children is set to false to save space when children aren't needed</param>
        public Structure(DBStructure obj, bool IncludeChildren)
        {
            DBStructure db = obj as DBStructure;

            this.ID = db.ID;
            this.TypeID = db.TypeID;
            this.Notes = db.Notes;
            this.Verified = db.Verified;


            if (db.Tags == null)
            {
                //_Tags = new string[0];
                _Xml = ""; 
            }
            else
            {
            //    _Tags = db.Tags.Split(';');
                _Xml = db.Tags;
            }
                

            this.Confidence = db.Confidence;
            this.ParentID = db.ParentID;

            this._Links = PopulateLinks(db);

            if (IncludeChildren)
            {
                List<long> childIDs = new List<long>(db.ChildStructures.Count);
                foreach (DBStructure Child in db.ChildStructures)
                {
                    childIDs.Add(Child.ID);
                }
                this._ChildIDs = childIDs.ToArray();
            }
            else
            {
                this._ChildIDs = null; 
            }
             
            this._Label = db.Label;
            this._Username = db.Username; 
        }

        public void Sync(DBStructure db)
        {
            db.TypeID = this.TypeID;
            db.Notes = this.Notes;
            db.Verified = this.Verified;        
            /*
            string tags = "";
            foreach (string s in _Tags)
            {
                if (tags.Length > 0)
                    tags = tags + ';' + s;
                else
                    tags = s; 
            }
            */
            db.Tags = this.AttributesXml;
            db.Confidence = this.Confidence;
            db.ParentID = this.ParentID;
            db.Label = this.Label;
            db.Username = ServiceModelUtil.GetUserForCall();
        }
    }

    
    [DataContract]
    public class StructureHistory : Structure
    {

        public StructureHistory(SelectStructureChangeLogResult db)
        {

            this.ID = db.ID.Value;
            this.TypeID = db.TypeID.Value;
            this.Notes = db.Notes;
            this.Verified = db.Verified.Value;

            /*
            if (db.Tags == null)
            { 
                _Xml = "";
            }
            else
            { 
                _Xml = db.Tags.ToString();
            }
            */

            this.Confidence = db.Confidence.Value;
            this.ParentID = db.ParentID.Value;
            this._Label = db.Label;
            this._Username = db.Username; 
        }

    }
}



