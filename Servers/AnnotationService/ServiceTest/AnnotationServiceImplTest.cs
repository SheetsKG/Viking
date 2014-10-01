﻿using Annotation;
using System; 
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Security;
using System.Security.Principal; 
//using System.Diagnostics;

namespace ServiceTest
{


    /// <summary>
    ///This is a test class for AnnotationServiceImplTest and is intended
    ///to contain all AnnotationServiceImplTest Unit Tests
    ///</summary>
    [TestClass()]
    public class AnnotationServiceImplTest
    {

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        private StructureType CreateStructureType(string Name)
        {
            StructureType t = new StructureType();
            t.Abstract = false;
            t.Code = "T";
            t.Color = 0;
            t.DBAction = DBACTION.INSERT;
            t.MarkupType = "Point";
            t.Name = Name;
            t.Notes = "";
            t.ParentID = new long?();

            return t; 
        }

        /// <summary>
        ///A test for UpdateStructureTypes
        ///</summary>
        [TestMethod()]
        public void InsertUpdateDeleteStructureTypesTest()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value
            string StructureTypeName = "TestStructureTypeInsert";

            StructureType t = CreateStructureType(StructureTypeName); 

            long[] IDs = target.UpdateStructureTypes(new StructureType[] { t } );
            long testID = IDs[0];

            StructureType[] allTypes = target.GetStructureTypes();
            StructureType insertedType = null;
            foreach (StructureType s in allTypes)
            {
                if (s.Name == StructureTypeName)
                {
                    insertedType = s;
                    break;
                }
            }

            Assert.IsNotNull(insertedType, "Could not find inserted type");

            t = target.GetStructureTypeByID(testID);

            /* Test Update */
            string UpdateTestName = "UpdateStructureTypesTest"; 
            string OriginalName = t.Name;
            Assert.AreEqual(t.Name, StructureTypeName);

            t.Name = UpdateTestName;
            t.DBAction = DBACTION.UPDATE;

            target.UpdateStructureTypes(new StructureType[] { t });

            t = target.GetStructureTypeByID(testID);

            Assert.AreEqual(t.Name, UpdateTestName);
            t.Name = OriginalName;
            t.DBAction = DBACTION.UPDATE;

            target.UpdateStructureTypes(new StructureType[] { t });

            t = target.GetStructureTypeByID(testID);
            Assert.AreEqual(t.Name, StructureTypeName);

            /* Test Delete */
            t.DBAction = DBACTION.DELETE;

            target.UpdateStructureTypes(new StructureType[] { t });

            allTypes = target.GetStructureTypes();
            StructureType deletedType = null;
            foreach (StructureType s in allTypes)
            {
                if (s.Name == StructureTypeName)
                {
                    deletedType = s;
                    break;
                }
            }

            Assert.IsNull(deletedType,"Found deleted type");

        }

        /// <summary>
        ///A test for GetStructureTypes
        ///</summary>
        [TestMethod()]
        public void GetStructureTypesTest()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value
            StructureType[] actual;
            actual = target.GetStructureTypes();
        }

        /// <summary>
        ///A test that creates a structure and a location for that structure, then deletes them
        ///</summary>
        [TestMethod()]
        public void CreateStructureTest()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value

            StructureType t = CreateStructureType("Test");

            long[] IDs = target.UpdateStructureTypes(new StructureType[] { t });
            long StructureTypeID = IDs[0];

            t = target.GetStructureTypeByID(StructureTypeID);

            Structure newStruct = new Structure();
            newStruct.TypeID = t.ID;

            Location newPos = new Location();
            newPos.ParentID = newStruct.ID;
            AnnotationPoint P = new AnnotationPoint();
            P.X = 0;
            P.Y = 0;
            P.Z = 0;
            newPos.Position = P;

            IDs = target.CreateStructure(newStruct, newPos);

            Structure dbStruct = target.GetStructureByID(IDs[0], false);
            Location dbPos = target.GetLocationByID(IDs[1]);

            Assert.IsTrue(dbStruct != null && dbStruct.ID == IDs[0]);
            Assert.IsTrue(dbPos != null && dbPos.ID == IDs[1]);

            dbPos.DBAction = DBACTION.DELETE;
            target.Update(new Location[] { dbPos });

            //Check to make sure there aren't any locations for the structure
            long queryTimeInTicks;
            Location[] structLocs = target.GetLocationsForSection(dbStruct.ID, out queryTimeInTicks);
            Assert.IsTrue(structLocs.Length == 0);

            dbStruct.DBAction = DBACTION.DELETE;
            target.UpdateStructures(new Structure[] { dbStruct });

            Structure dbStructNull = target.GetStructureByID(IDs[0], false);
            Location dbPosNull = target.GetLocationByID(IDs[1]);

            Assert.IsNull(dbStructNull);
            Assert.IsNull(dbPosNull);

            //Delete the structure type
            t.DBAction = DBACTION.DELETE;
            target.UpdateStructureTypes(new StructureType[] { t }); 
        }

        /// <summary>
        ///A test that creates a structure and a location for that structure, then deletes them
        ///</summary>
        [TestMethod()]
        public void CreateStructureLinkTest()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value

            StructureType t = CreateStructureType("Test");

            long[] IDs = target.UpdateStructureTypes(new StructureType[] { t });
            long[] IDsA; //ID's for struct A
            long[] IDsB; //ID's for struct B
            long StructureTypeID = IDs[0];

            t = target.GetStructureTypeByID(StructureTypeID);

            Structure newStructA = new Structure();
            Structure newStructB = new Structure(); 

            newStructA.TypeID = t.ID;
            newStructB.TypeID = t.ID;

            //Create location A
            Location newPosA = new Location();
            newPosA.ParentID = newStructA.ID;

            AnnotationPoint P = new AnnotationPoint();
            P.X = 0;
            P.Y = 0;
            P.Z = 0;
            newPosA.Position = P;

            IDsA = target.CreateStructure(newStructA, newPosA);

            //CreateLocationB
            Location newPosB = new Location();
            newPosB.ParentID = newStructB.ID;

            AnnotationPoint Pb = new AnnotationPoint();
            Pb.X = -1;
            Pb.Y = -1;
            Pb.Z = -1;
            newPosA.Position = Pb;
            
            IDsB = target.CreateStructure(newStructB, newPosB);

            Structure dbStructA = target.GetStructureByID(IDsA[0], false);
            Location dbPosA = target.GetLocationByID(IDsA[1]);

            Structure dbStructB = target.GetStructureByID(IDsB[0], false);
            Location dbPosB = target.GetLocationByID(IDsB[1]);

            Assert.IsTrue(dbStructA != null && dbStructA.ID == IDsA[0]);
            Assert.IsTrue(dbPosA != null && dbPosA.ID == IDsA[1]);
            Assert.IsTrue(dbStructB != null && dbStructB.ID == IDsB[0]);
            Assert.IsTrue(dbPosB != null && dbPosB.ID == IDsB[1]);

            //Link the structures
            StructureLink link = new StructureLink();
            link.SourceID = IDsA[0];
            link.TargetID = IDsB[0];
            
            target.CreateStructureLink(link); 

            //Delete the link
            link.DBAction = DBACTION.DELETE;

            target.UpdateStructureLinks(new StructureLink[] { link }); 

            dbPosA.DBAction = DBACTION.DELETE;
            dbPosB.DBAction = DBACTION.DELETE;
            target.Update(new Location[] { dbPosA, dbPosB });

            //Check to make sure there aren't any locations for the structure
            long queryTimeInTicks;
            Location[] structLocs = target.GetLocationsForSection(dbStructA.ID, out queryTimeInTicks);
            Assert.IsTrue(structLocs.Length == 0);

            dbStructA.DBAction = DBACTION.DELETE;
            dbStructB.DBAction = DBACTION.DELETE;
            target.UpdateStructures(new Structure[] { dbStructA, dbStructB });

            Structure dbStructANull = target.GetStructureByID(IDsA[0], false);
            Location dbPosANull = target.GetLocationByID(IDsA[1]);
            Structure dbStructBNull = target.GetStructureByID(IDsB[0], false);
            Location dbPosBNull = target.GetLocationByID(IDsB[1]);

            Assert.IsNull(dbStructANull);
            Assert.IsNull(dbPosANull);
            Assert.IsNull(dbStructBNull);
            Assert.IsNull(dbPosBNull);

            //Delete the structure type
            t.DBAction = DBACTION.DELETE;
            target.UpdateStructureTypes(new StructureType[] { t });
        }

        /// <summary>
        ///A test that creates a structure and a location for that structure, then deletes them
        ///</summary>
        [TestMethod()]
        public void LocationLinkTest()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value

            //Create a structure type, a structure, and some links
            StructureType t = CreateStructureType("Test");

            long[] IDs = target.UpdateStructureTypes(new StructureType[] { t });
            long StructureTypeID = IDs[0];

            //Create structure and location
            Structure newStruct = new Structure();
            newStruct.TypeID = StructureTypeID;

            Location newPos = new Location();
            newPos.ParentID = newStruct.ID;
            AnnotationPoint P = new AnnotationPoint();
            P.X = 0;
            P.Y = 0;
            P.Z = 0;
            newPos.Position = P;

            IDs = target.CreateStructure(newStruct, newPos);
            long StructureID = IDs[0];
            long LocationAID = IDs[1]; 

            //Create a second location for the structure, linked to the first
            Location B = new Location();
            B.ParentID = StructureID;
            P.Z = 1;
            B.Position = P;
            B.DBAction = DBACTION.INSERT; 

            IDs = target.Update(new Location[] { B } );
            long LocationBID = IDs[0]; 

            target.CreateLocationLink(LocationAID, LocationBID);

            target.DeleteLocationLink(LocationBID, LocationAID);


            //Delete the locations
            Location LocationA = target.GetLocationByID(LocationAID);
            Location LocationB = target.GetLocationByID(LocationBID);

            LocationA.DBAction = DBACTION.DELETE;
            LocationB.DBAction = DBACTION.DELETE;

            target.Update( new Location[] { LocationA, LocationB}); 

            //Delete the structure
            newStruct = target.GetStructureByID(StructureID, false);
            newStruct.DBAction = DBACTION.DELETE;

            target.UpdateStructures(new Structure[] { newStruct });

            //Delete the structure type
            t = target.GetStructureTypeByID(StructureTypeID);
            t.DBAction = DBACTION.DELETE;

            target.UpdateStructureTypes(new StructureType[] { t }); 
        }

        /// <summary>
        ///A test that creates a structure and a location for that structure, then deletes them
        ///</summary>
        [TestMethod()]
        public void TestQueryLocationChanges()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value

            //Create a structure type, a structure, and some links
            StructureType t = CreateStructureType("Test");

            long[] IDs = target.UpdateStructureTypes(new StructureType[] { t });
            long StructureTypeID = IDs[0];

            //Create structure and location
            Structure newStruct = new Structure();
            newStruct.TypeID = StructureTypeID;

            Location newPos = new Location();
            newPos.ParentID = newStruct.ID;
            AnnotationPoint P = new AnnotationPoint();
            P.X = 0;
            P.Y = 0;
            P.Z = 0;
            newPos.Position = P;

            IDs = target.CreateStructure(newStruct, newPos);
            long StructureID = IDs[0];
            long LocationAID = IDs[1];

            //Create a second location for the structure
            Location B = new Location();
            B.ParentID = StructureID;
            P.Z = 0;
            B.Position = P;
            B.DBAction = DBACTION.INSERT;

            IDs = target.Update(new Location[] { B });
            long LocationBID = IDs[0];

            //Query the locations
            Location[] Locations = target.GetLocationsForStructure(StructureID);
            Assert.IsTrue(Locations.Length == 2);

             

            //Create a third location for the structure
            Location C = new Location();
            C.ParentID = StructureID;
            P.Z = 0;
            C.Position = P;
            C.DBAction = DBACTION.INSERT;

            IDs = target.Update(new Location[] { C });
            long LocationCID = IDs[0];

            //Query all the structures
            Location LocationA = target.GetLocationByID(LocationAID);
            Location LocationB = target.GetLocationByID(LocationBID);
            Location LocationC = target.GetLocationByID(LocationCID);


            DateTime UpdateTime = new DateTime(LocationC.LastModified, DateTimeKind.Utc);
//            UpdateTime = UpdateTime.Subtract(new TimeSpan(TimeSpan.TicksPerMillisecond)); //The server only returns changes after the query 

            System.Diagnostics.Debug.WriteLine("UpdateTime: " + UpdateTime.ToFileTime().ToString());

            //Check that location C appears when we ask for locations modified after the updatetime
            long[] deletedIDs;
            long queryTimeInTicks;
            Location[] updatedLocations = target.GetLocationChanges(LocationA.Section,
                                                                    UpdateTime.Ticks,
                                                                    out queryTimeInTicks,
                                                                    out deletedIDs);

            //Nothing was deleted, so this should be true
            foreach (long id in deletedIDs)
            {
                Assert.IsTrue(id != LocationAID, "Found undeleted ID in deleted list");
                Assert.IsTrue(id != LocationBID, "Found undeleted ID in deleted list");
                Assert.IsTrue(id != LocationCID, "Found undeleted ID in deleted list");
            }

            //Other people could be changing the database, so check the LocationC is in the array, but not A or B
            bool CFound = false; 
            foreach(Location loc in updatedLocations)
            {
                Assert.IsTrue(loc.ID != LocationAID && loc.ID != LocationBID);
                if (loc.ID == LocationCID)
                    CFound = true; 
            }

            Assert.IsTrue(CFound, "Could not find location C");

            //This will only be true if the test is run on the server
            UpdateTime = new DateTime(queryTimeInTicks, DateTimeKind.Utc);

            System.Diagnostics.Debug.WriteLine("UpdateTime: " + UpdateTime.ToFileTime().ToString());
            
            //Delete location B, and check that it shows up in the deleted IDs
            LocationB.DBAction = DBACTION.DELETE;
            target.Update(new Location[] { LocationA, LocationB, LocationC });
            
            //Just so I don't reference it again. 
            LocationB = null; 

            updatedLocations = target.GetLocationChanges(LocationA.Section,
                                                         UpdateTime.Ticks,
                                                         out queryTimeInTicks,
                                                         out deletedIDs);

            //B was deleted, so make sure it is in the results
            bool BFound = false; 
            foreach (long id in deletedIDs)
            {
                if (id == LocationBID)
                    BFound = true; 

                Assert.IsTrue(id != LocationAID);
                Assert.IsTrue(id != LocationCID);
            }

            Assert.IsTrue(BFound); 

            //Other people could be changing the database, so check that neither A or C is in the updated array
            foreach (Location loc in updatedLocations)
            {
                Assert.IsTrue(loc.ID != LocationAID && loc.ID != LocationCID);
            }


            //Update A location and delete C
            LocationA.OffEdge = true;
            LocationA.DBAction = DBACTION.UPDATE;
            LocationC.DBAction = DBACTION.DELETE;
            target.Update(new Location[] { LocationA, LocationC });

            LocationC = null;

            LocationA = target.GetLocationByID(LocationAID);

            UpdateTime = new DateTime(LocationA.LastModified, DateTimeKind.Utc);
//            UpdateTime = UpdateTime.Subtract(new TimeSpan(TimeSpan.TicksPerMillisecond)); //The server only returns changes after the query 

            System.Diagnostics.Debug.WriteLine("UpdateTime: " + LocationA.LastModified.ToString());

            updatedLocations = target.GetLocationChanges(LocationA.Section,
                                                         UpdateTime.Ticks,
                                                         out queryTimeInTicks,
                                                         out deletedIDs);

            //Check to see that we find location C in deletedIDs and LocationA in the updated set
            //Other people could be changing the database, so check the LocationC is in the array, but not A or B
            bool AFound = false;
            foreach (Location loc in updatedLocations)
            {
                Assert.IsTrue(loc.ID != LocationBID && loc.ID != LocationCID);
                if (loc.ID == LocationAID)
                    AFound = true;
            }

            Assert.IsTrue(AFound, "Could not find changed row in GetLocationChanges"); 

            //C was deleted, so make sure it is in the results
            CFound = false;
            foreach (long id in deletedIDs)
            {
                if (id == LocationCID)
                    CFound = true;

                Assert.IsTrue(id != LocationAID);
                Assert.IsTrue(id != LocationBID);
            }

            Assert.IsTrue(CFound); 

            //Wrap up, delete A
            LocationA.DBAction = DBACTION.DELETE;
            target.Update(new Location[] { LocationA });
            
            //Delete the structure
            newStruct = target.GetStructureByID(StructureID, false);
            newStruct.DBAction = DBACTION.DELETE;

            target.UpdateStructures(new Structure[] { newStruct });

            //Delete the structure type
            t = target.GetStructureTypeByID(StructureTypeID);
            t.DBAction = DBACTION.DELETE;

            target.UpdateStructureTypes(new StructureType[] { t });
        }

        [TestMethod()]
        public void TestGetAnnotationLocations()
        {
            AddPrincipalToThread();

            AnnotateService target = new AnnotateService(); // TODO: Initialize to an appropriate value

            Location[] Data = target.GetLocationsForStructure(514);

            Assert.IsNotNull(Data); 
        }

        private void AddPrincipalToThread()
        {
            GenericIdentity ident = new GenericIdentity("Test");
            string[] roles = new string[] { @"Admin", @"Modify", @"Read"};
            GenericPrincipal principle = new GenericPrincipal(ident,roles);
            
            System.Threading.Thread.CurrentPrincipal = principle;
        }
    }
}
