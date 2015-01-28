﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

using AnnotationVizLib;

namespace VikingWebAppSettings
{ 
    public static class AppSettings
    {
        public static string GetApplicationSetting(string name)
        {
            if (!WebConfigurationManager.AppSettings.HasKeys())
            {
                throw new ArgumentException(name + " not configured in AppSettings");
            }

            string setting = WebConfigurationManager.AppSettings[name];
            if (setting == null)
            {
                throw new ArgumentException(name + " not configured in AppSettings");
            }

            return setting;
        }

        public static string GetDatabaseServer()
        {
            return GetApplicationSetting("DatabaseServer");
        }

        public static string GetDatabaseCatalogName()
        {
            return GetApplicationSetting("DatabaseCatalog");
        } 

        public static string GetConnectionString(string name)
        { 
            if (WebConfigurationManager.ConnectionStrings.Count == 0)
            {
                throw new ArgumentException(name + " not configured as ConnectionString");
            }

            string conn_string = WebConfigurationManager.ConnectionStrings[name].ConnectionString;
            if(conn_string == null)
            {
                throw new ArgumentException(name + " not configured as ConnectionString");
            }

            return conn_string;
        }
         
        public static string WebServiceURLTemplate
        {
            get
            {
                return GetApplicationSetting("EndpointURLTemplate");
            }
        }


        public static string WebServiceURL
        {
            get
            {
                return GetApplicationSetting("EndpointURL");
            }
        }

        public static System.Net.NetworkCredential EndpointCredentials
        {
            get
            {
                System.Net.NetworkCredential userCredentials = new System.Net.NetworkCredential(GetApplicationSetting("EndpointUsername"), GetApplicationSetting("EndpointPassword"));
                return userCredentials;
            }
        }

        public static Scale GetScale()
        {
            AxisUnits X, Y, Z;

#if DEBUG
            try
            {
#endif
                X = new AxisUnits(System.Convert.ToDouble(GetApplicationSetting("XScaleValue")),
                                            GetApplicationSetting("XScaleUnits"));

                Y = new AxisUnits(System.Convert.ToDouble(GetApplicationSetting("YScaleValue")),
                                            GetApplicationSetting("YScaleUnits"));

                Z = new AxisUnits(System.Convert.ToDouble(GetApplicationSetting("ZScaleValue")),
                                            GetApplicationSetting("ZScaleUnits"));
#if DEBUG
            }
            catch(ArgumentException)
            {
                X = new AxisUnits(2.18, "nm");

                Y = new AxisUnits(2.18, "nm");

                Z = new AxisUnits(90, "nm");
            }
#endif

            return new Scale(X, Y, Z); 
        }
          
    }
}