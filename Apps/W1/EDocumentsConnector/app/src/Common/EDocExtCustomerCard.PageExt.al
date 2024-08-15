// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.EServices.EDocumentConnector;

using Microsoft.Sales.Customer;

pageextension 6360 "E-Doc. Ext. Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("Document Sending Profile")
        {
            field("SignUpService Participant Id"; Rec."Service Participant Id")
            {
                ApplicationArea = All;
                Caption = 'Service Participant Id';
                ToolTip = 'Specifies customer service participant Id. used by the E-Document Service.';
            }
        }
    }
}