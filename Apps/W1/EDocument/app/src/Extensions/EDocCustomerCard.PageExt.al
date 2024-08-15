pageextension 6163 "E-Doc. Customer Page" extends "Customer Card"
{
    layout
    {
        addafter("Document Sending Profile")
        {
            field("Service Participant Id"; Rec."Service Participant Id")
            {
                ApplicationArea = All;
                Caption = 'Service Participant Id';
                ToolTip = 'Specifies customer service participant Id. used by the E-Document Service.';
            }
        }
    }
}