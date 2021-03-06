﻿namespace WebAnnotation.UI
{
    partial class StructureTypeGeneralPage
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelName = new System.Windows.Forms.Label();
            this.textName = new System.Windows.Forms.TextBox();
            this.labelNotes = new System.Windows.Forms.Label();
            this.textNotes = new System.Windows.Forms.RichTextBox();
            this.labelColor = new System.Windows.Forms.Label();
            this.colorDialog = new System.Windows.Forms.ColorDialog();
            this.btnColor = new System.Windows.Forms.Button();
            this.textCode = new System.Windows.Forms.TextBox();
            this.labelCode = new System.Windows.Forms.Label();
            this.textID = new System.Windows.Forms.TextBox();
            this.labelID = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // labelName
            // 
            this.labelName.AutoSize = true;
            this.labelName.Location = new System.Drawing.Point(16, 36);
            this.labelName.Name = "labelName";
            this.labelName.Size = new System.Drawing.Size(38, 13);
            this.labelName.TabIndex = 0;
            this.labelName.Text = "Name:";
            // 
            // textName
            // 
            this.textName.Location = new System.Drawing.Point(19, 52);
            this.textName.Name = "textName";
            this.textName.Size = new System.Drawing.Size(240, 20);
            this.textName.TabIndex = 3;
            // 
            // labelNotes
            // 
            this.labelNotes.AutoSize = true;
            this.labelNotes.Location = new System.Drawing.Point(16, 155);
            this.labelNotes.Name = "labelNotes";
            this.labelNotes.Size = new System.Drawing.Size(38, 13);
            this.labelNotes.TabIndex = 6;
            this.labelNotes.Text = "Notes:";
            // 
            // textNotes
            // 
            this.textNotes.Location = new System.Drawing.Point(19, 171);
            this.textNotes.Name = "textNotes";
            this.textNotes.Size = new System.Drawing.Size(240, 173);
            this.textNotes.TabIndex = 7;
            this.textNotes.Text = "";
            // 
            // labelColor
            // 
            this.labelColor.AutoSize = true;
            this.labelColor.Location = new System.Drawing.Point(16, 124);
            this.labelColor.Name = "labelColor";
            this.labelColor.Size = new System.Drawing.Size(34, 13);
            this.labelColor.TabIndex = 8;
            this.labelColor.Text = "Color:";
            // 
            // btnColor
            // 
            this.btnColor.Location = new System.Drawing.Point(56, 119);
            this.btnColor.Name = "btnColor";
            this.btnColor.Size = new System.Drawing.Size(75, 23);
            this.btnColor.TabIndex = 9;
            this.btnColor.UseVisualStyleBackColor = true;
            this.btnColor.Click += new System.EventHandler(this.btnColor_Click);
            // 
            // textCode
            // 
            this.textCode.Location = new System.Drawing.Point(19, 91);
            this.textCode.MaxLength = 16;
            this.textCode.Name = "textCode";
            this.textCode.Size = new System.Drawing.Size(240, 20);
            this.textCode.TabIndex = 11;
            // 
            // labelCode
            // 
            this.labelCode.AutoSize = true;
            this.labelCode.Location = new System.Drawing.Point(16, 75);
            this.labelCode.Name = "labelCode";
            this.labelCode.Size = new System.Drawing.Size(35, 13);
            this.labelCode.TabIndex = 10;
            this.labelCode.Text = "Code:";
            // 
            // textID
            // 
            this.textID.Location = new System.Drawing.Point(40, 8);
            this.textID.MaxLength = 16;
            this.textID.Name = "textID";
            this.textID.ReadOnly = true;
            this.textID.Size = new System.Drawing.Size(219, 20);
            this.textID.TabIndex = 13;
            // 
            // labelID
            // 
            this.labelID.AutoSize = true;
            this.labelID.Location = new System.Drawing.Point(16, 11);
            this.labelID.Name = "labelID";
            this.labelID.Size = new System.Drawing.Size(21, 13);
            this.labelID.TabIndex = 12;
            this.labelID.Text = "ID:";
            // 
            // StructureTypeGeneralPage
            // 
            this.Controls.Add(this.textID);
            this.Controls.Add(this.labelID);
            this.Controls.Add(this.textCode);
            this.Controls.Add(this.labelCode);
            this.Controls.Add(this.btnColor);
            this.Controls.Add(this.labelColor);
            this.Controls.Add(this.textNotes);
            this.Controls.Add(this.labelNotes);
            this.Controls.Add(this.textName);
            this.Controls.Add(this.labelName);
            this.Name = "StructureTypeGeneralPage";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelName;
        private System.Windows.Forms.TextBox textName;
        private System.Windows.Forms.Label labelNotes;
        private System.Windows.Forms.RichTextBox textNotes;
        private System.Windows.Forms.Label labelColor;
        private System.Windows.Forms.ColorDialog colorDialog;
        private System.Windows.Forms.Button btnColor;
        private System.Windows.Forms.TextBox textCode;
        private System.Windows.Forms.Label labelCode;
        private System.Windows.Forms.TextBox textID;
        private System.Windows.Forms.Label labelID;
    }
}
