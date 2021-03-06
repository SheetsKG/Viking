﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using Annotation.Service.GraphClasses;

namespace Annotation.Service.Interfaces
{
    [ServiceContract]
    interface ICircuit
    {
        [OperationContract]
        Graphx getGraph(int cellID, int numHops);

        [OperationContract]
        long[] getStructuresByTypeID(int typeID);

        [OperationContract]
        string[] getSynapses(int cellID);

        [OperationContract]
        SynapseObject getSynapseStats();

        [OperationContract]
        string[] getTopConnectedStructures(int num);

        [OperationContract]
        string[] getTopConnectedCells();
    }
}
