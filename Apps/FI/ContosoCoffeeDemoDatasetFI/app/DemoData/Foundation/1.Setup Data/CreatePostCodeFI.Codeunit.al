// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace Microsoft.DemoData.Foundation;

using Microsoft.DemoTool.Helpers;

codeunit 13401 "Create Post Code FI"
{
    InherentEntitlements = X;
    InherentPermissions = X;
    trigger OnRun()
    var
        ContosoPostCodeFI: Codeunit "Contoso Post Code FI";
        CreateCountryRegion: Codeunit "Create Country/Region";
    begin
        ContosoPostCodeFI.InsertPostCode('00100', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('00101', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('00170', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('00260', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('01201', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('01800', KLAUKKALALbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('02170', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('02300', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('05400', JokelaLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('10300', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('20100', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('23500', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('33200', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('33470', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('37600', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('40530', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('45160', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('50500', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('57810', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('60320', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('66900', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('67100', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('80100', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('83500', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('88900', KuhmoLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('90100', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('94200', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('95600', HelsinkiLbl, CreateCountryRegion.FI());
        ContosoPostCodeFI.InsertPostCode('GB-B27 4KT', BirminghamLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-B31 2AL', BirminghamLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-B32 4TF', SparkhillBirminghamLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-B68 5TT', BromsgroveLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-BA24 6KS', BathLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-BR1 2ES', BromleyLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-BS3 6KL', BristolLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-CB3 7GG', CambridgeLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-CF22 1XU', CardiffLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-CT6 21ND', HytheLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-CV6 1GY', CoventryLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-DA5 3EF', SidcupLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-DY5 4DJ', DudleyLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-E12 5TG', EdinburghLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-EH16 8JS', EdinburghLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-GL1 9HM', GloucesterLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-GL78 5TT', CheltenhamLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-GU3 2SE', GuildfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-GU7 5GT', GuildfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-HG1 7YW', RiponLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-HP43 2AY', TringLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-IB7 7VN', GainsboroughLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-L18 6SA', LiverpoolLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-LE16 7YH', LeicesterLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-LL6 5GB', RhylLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-LN23 6GS', LincolnLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-LU3 4FY', LutonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-M61 2YG', ManchesterLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-ME5 6RL', MaidstoneLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-MK21 7GG', BletchleyLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-MK41 5AE', BedfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-MO2 4RT', ManchesterLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-N12 5XY', LondonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-N16 34Z', LondonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-NE21 3YG', NewcastleLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-NP5 6GH', NewportLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-OX16 0UA', CheddingtonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PE17 4RN', CambridgeLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PE21 3TG', PeterboroughLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PE23 5IK', KingsLynnLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PL14 5GB', PlymouthLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PO21 6HG', SouthseaPortsmouthLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-PO7 2HI', PortsmouthLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-SA1 2HS', SwanseaLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-SA3 7HI', StratfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-SK21 5DL', MacclesfieldLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-TA3 4FD', NewquayLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-TN27 6YD', AshfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-TQ17 8HB', BrixhamLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-W1 3AL', LondonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-W2 8HG', LondonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WC1 2GS', WestEndLaneLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WC1 3DG', LondonLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WD1 6YG', WatfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WD2 4RG', WatfordLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WD6 8UY', BorehamwoodLbl, CreateCountryRegion.GB());
        ContosoPostCodeFI.InsertPostCode('GB-WD6 9HY', BorehamwoodLbl, CreateCountryRegion.GB());
    end;

    var
        HelsinkiLbl: Label 'Helsinki', MaxLength = 30;
        KlaukkalaLbl: Label 'Klaukkala', MaxLength = 30;
        JokelaLbl: Label 'Jokela', MaxLength = 30;
        WestEndLaneLbl: Label 'West End Lane', MaxLength = 30;
        WatfordLbl: Label 'Watford', MaxLength = 30;
        LondonLbl: Label 'London', MaxLength = 30;
        BorehamwoodLbl: Label 'Borehamwood', MaxLength = 30;
        GuildfordLbl: Label 'Guildford', MaxLength = 30;
        BirminghamLbl: Label 'Birmingham', MaxLength = 30;
        SparkhillBirminghamLbl: Label 'Sparkhill, Birmingham', MaxLength = 30;
        BathLbl: Label 'Bath', MaxLength = 30;
        CambridgeLbl: Label 'Cambridge', MaxLength = 30;
        BristolLbl: Label 'Bristol', MaxLength = 30;
        HytheLbl: Label 'Hythe', MaxLength = 30;
        CardiffLbl: Label 'Cardiff', MaxLength = 30;
        CoventryLbl: Label 'Coventry', MaxLength = 30;
        BromsgroveLbl: Label 'Bromsgrove', MaxLength = 30;
        EdinburghLbl: Label 'Edinburgh', MaxLength = 30;
        DudleyLbl: Label 'Dudley', MaxLength = 30;
        GloucesterLbl: Label 'Gloucester', MaxLength = 30;
        BromleyLbl: Label 'Bromley', MaxLength = 30;
        SidcupLbl: Label 'Sidcup', MaxLength = 30;
        CheltenhamLbl: Label 'Cheltenham', MaxLength = 30;
        GainsboroughLbl: Label 'Gainsborough', MaxLength = 30;
        LiverpoolLbl: Label 'Liverpool', MaxLength = 30;
        RhylLbl: Label 'Rhyl', MaxLength = 30;
        LeicesterLbl: Label 'Leicester', MaxLength = 30;
        LincolnLbl: Label 'Lincoln', MaxLength = 30;
        ManchesterLbl: Label 'Manchester', MaxLength = 30;
        BedfordLbl: Label 'Bedford', MaxLength = 30;
        BletchleyLbl: Label 'Bletchley', MaxLength = 30;
        NewcastleLbl: Label 'Newcastle', MaxLength = 30;
        MaidstoneLbl: Label 'Maidstone', MaxLength = 30;
        LutonLbl: Label 'Luton', MaxLength = 30;
        TringLbl: Label 'Tring', MaxLength = 30;
        RiponLbl: Label 'Ripon', MaxLength = 30;
        NewportLbl: Label 'Newport', MaxLength = 30;
        PlymouthLbl: Label 'Plymouth', MaxLength = 30;
        PeterboroughLbl: Label 'Peterborough', MaxLength = 30;
        MacclesfieldLbl: Label 'Macclesfield', MaxLength = 30;
        BrixhamLbl: Label 'Brixham', MaxLength = 30;
        AshfordLbl: Label 'Ashford', MaxLength = 30;
        CheddingtonLbl: Label 'Cheddington', MaxLength = 30;
        SwanseaLbl: Label 'Swansea', MaxLength = 30;
        StratfordLbl: Label 'Stratford', MaxLength = 30;
        PortsmouthLbl: Label 'Portsmouth', MaxLength = 30;
        NewquayLbl: Label 'Newquay', MaxLength = 30;
        KingsLynnLbl: Label 'Kings Lynn', MaxLength = 30;
        SouthseaPortsmouthLbl: Label 'Southsea, Portsmouth', MaxLength = 30;
        KuhmoLbl: Label 'Kuhmo', MaxLength = 30;
}
