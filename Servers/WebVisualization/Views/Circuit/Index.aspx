﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage"  %>

<script runat="server">    
        
    protected void Page_Load(object sender, EventArgs e)
    {
        string vHost = "http://" + HttpContext.Current.Request.Url.Authority;
        string vPath = HttpContext.Current.Request.ApplicationPath;
        if (vPath == "/")
            vPath = "";
        string webPath = vHost + vPath + "/Circuit/Trace/";
        form1.Action = webPath;

        foreach (String t in ConnectomeViz.Models.State.labsDictionary.Keys.ToArray<String>())
        {
            labName.Items.Insert(labName.Items.Count, new ListItem(t, t));
        }

        labName.SelectedIndex = 0;
       
        ConnectomeViz.Models.State.selectedLab = labName.SelectedValue.ToString();

        foreach (string str in ConnectomeViz.Models.State.labsDictionary[ConnectomeViz.Models.State.selectedLab])
        {
            dataSource.Items.Insert(dataSource.Items.Count, new ListItem(str, str));
        }

        dataSource.SelectedIndex = 0;


        string val = ConnectomeViz.Models.State.selectedService;

        //if (!String.IsNullOrEmpty(val))
        //{
        //    List<string> keys = ConnectomeViz.Models.State.serviceDictionary.Keys.ToList<string>();
        //    for (int i = 0; i < keys.Count; i++)
        //    {
        //        if (keys[i].ToString().Equals(val))
        //            dataSource.SelectedIndex = i;
        //    }
        //}
    }
</script>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
   Circuit Visualization
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server"> 
    <% string vHost = "http://" + HttpContext.Current.Request.Url.Authority;
        
   string vPath = HttpContext.Current.Request.ApplicationPath;
   if (vPath == "/")
       vPath = "";
   string webPath = vHost + vPath; %>    
 <script type="text/javascript" language="javascript" src="<%=webPath%>/Scripts/TabControl.js"></script>
 <script type="text/javascript" language="javascript" src="<%=webPath%>/Scripts/CircuitScript.js"></script>
 <script type="text/javascript" language="javascript">
     window.onload = function () {

         

         typeOfCall = 1;

         var animatorIconPath = "<%=webPath%>/Content/ajax-loader.gif";

         document.getElementById("progress").src = animatorIconPath;

         document.getElementById("arrow").src = "<%=webPath%>/Content/icons/arrow_b_r.png";

        $("#arrow")
        .mouseover(function () {
            var src = "<%=webPath%>/Content/icons/arrow_g_r.png";
            $(this).attr("src", src);
        })
        .mouseout(function () {
            var src = "<%=webPath%>/Content/icons/arrow_b_r.png";
            $(this).attr("src", src);
        });
     

         
         structureClientID = "<%=structureID.ClientID%>";

         dataSourceClientID = "<%=dataSource.ClientID%>";

         labNameClientID = "<%=labName.ClientID%>";

         RunAfterLoad();
     }

//     function colorImage(tag)
//     {
//        tag.src = "<%=webPath%>/Content/icons/arrow_g_r.png";
//     }
//     function removeColor(tag)
//     {
//        tag.src = "<%=webPath%>/Content/icons/arrow_b_r.png";
//     }

 </script>
 
  <form method="post" action="<%=webPath%>/FormRequest/ExportToExcel">
    <input type="hidden" name="gridData" id="gridData" value="" />
</form>

   <div>   
      <form id="form1" runat="server">
        <label style="font-size: medium">
        <br />
        &nbsp; Select Lab&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp; &nbsp;<asp:DropDownList 
            id="labName" clientIDMode="Static" runat="server" 
           onchange="updateLab()" Height="23px" title="Select a Lab">
        </asp:DropDownList>&nbsp; &amp;&nbsp; Volume :
        <asp:DropDownList id="dataSource"  clientIDMode="Static" onchange="updateList()"
         runat="server" Height="23px"></asp:DropDownList>&nbsp; then&nbsp;&nbsp;&nbsp;
              <br />
        &nbsp;<br />
        &nbsp; Enter Cell ID&nbsp;&nbsp;&nbsp; :</label>&nbsp;&nbsp;&nbsp; <input type="text" id="cellID" name="cellID" 
         onkeydown="update_button()" onkeyup="update_button()" onfocus="update_button()" onmousemove="update_button()" 
         onchange="update_button()" onkeypress="update_button()" onmouseout="update_button()" autocomplete="off" title="Enter a Cell ID"/>
       &nbsp;<label style="font-size:medium"></label>
        <label style="font-size: medium">
        (or) 
        Choose from List : <asp:DropDownList id="structureID" clientIDMode="Static" onchange= "update_button1()" runat="server">
        </asp:DropDownList> <a href="#circuitGrid" id="circuitButton" name="modal" style="display:none">
                    <img  border="0" id="arrow" src="" alt="explore" height="24" width="24" src="" align="absmiddle"/></a>
      <br />
      <br />
        &nbsp; </label>
        <label style="font-size:medium"> Choose Hops&nbsp;&nbsp;&nbsp; :</label>&nbsp;&nbsp;
        <select name="hops">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3" selected="selected">3</option>     
        <option value="12">Max Possible</option>
      



        </select>&nbsp;&nbsp;<strong><span class="Apple-style-span" 
            style="border-collapse: separate; color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px; text-transform: none; white-space: normal; windows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: 0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; font-size: medium; "><span 
            class="style1" 
            style="color: rgb(51, 51, 51); font-family: Verdana, Arial, sans-serif; line-height: 14px;"> 
        → </span></span>
        <input name="freshQuery" id="freshQuery" type="checkbox" value="latest" /> Update 
        Graph</strong>&nbsp;&nbsp;&nbsp;
       <input type="submit" id="submitButton" disabled="disabled" value="Go" onclick="animate()"/>&nbsp;&nbsp;&nbsp;&nbsp;
       <label id="message" style="font-size:small"></label>
       <img id="progress" style="visibility:hidden;" height="25" width="25" src="" align="absmiddle" alt="Loading..."/>
           <br /><br /> 

         
         &nbsp; 

         
         <input type="radio" name="group1" value="generate" id="svgGraph" checked="checked"/> <strong>Interactive Graph </strong>
        
        &nbsp;<input type="radio" name="group1" value="flash" id="flashGraph" /> <strong>Flash Graph</strong>        
        &nbsp;<strong> |</strong>&nbsp;&nbsp;
         <input name="reduceEdges" id="reduceEdges" type="checkbox" value="reduce" checked="checked"/><strong>Reduce edges</strong>&nbsp;&nbsp;
        <input name="pinNodes" id="pinNodes" type="checkbox" value="nodepos" /> <strong>
        Anatomic Node Positions&nbsp;&nbsp; </strong><br/><br />      
      </form>  
  </div>  

 

  
    
    

</asp:Content>


<asp:Content ID="Content1" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .style1
        {
            font-size: large;
        }
        #flashGraph
        {
            font-weight: 700;
        }
    </style>
</asp:Content>



