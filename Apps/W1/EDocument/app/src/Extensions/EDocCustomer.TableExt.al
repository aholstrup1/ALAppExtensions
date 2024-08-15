tableextension 6163 "E-Doc. Customer" extends Customer
{
    fields
    {
        field(6102; "Service Participant Id"; Text[50])
        {
            Caption = 'Service Participant Id';
            DataClassification = CustomerContent;
        }
    }
}