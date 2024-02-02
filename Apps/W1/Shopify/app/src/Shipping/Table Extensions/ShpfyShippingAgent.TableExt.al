namespace Microsoft.Integration.Shopify;

using Microsoft.Foundation.Shipping;

/// <summary>
/// TableExtension Shpfy Shipping Agent (ID 30105) extends Record Shipping Agent.
/// </summary>
tableextension 30105 "Shpfy Shipping Agent" extends "Shipping Agent"
{
    fields
    {
#pragma warning disable AL0842
        field(30100; "Shpfy Tracking Company"; Enum "Shpfy Tracking Companies")
#pragma warning restore AL0842
        {
            Caption = 'Shopify Tracking Company';
            DataClassification = CustomerContent;
        }
    }
}