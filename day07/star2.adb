with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;

procedure Star2 is
    package NumVector is new Ada.Containers.Vectors (Element_Type => Natural, Index_Type => Natural);

    function ParseFileContent (FileContent : String) return NumVector.Vector is
        Content : NumVector.Vector;

        F : Positive;
        L : Natural;
        I : Natural := 1;

        Comma : constant Ada.Strings.Maps.Character_Set := Ada.Strings.Maps.To_Set (',');
    begin
        while I in FileContent'Range loop
            Ada.Strings.Fixed.Find_Token (Source => FileContent, Set => Comma, From => I, Test => Ada.Strings.Outside, First => F, Last => L);

            --  Ada.Text_IO.Put_Line ("Inside loop, L: " & Natural'Image (L));
            exit when L = 0;
            
            Content.Append (Natural'Value (FileContent (F .. L)));

            I := L + 1;
        end loop;

        return Content;
    end ParseFileContent;

    procedure PrintNumber (Position : NumVector.Cursor) is
    begin
        Ada.Text_IO.Put (Natural'Image (NumVector.Element (Position)) & ", ");
    end PrintNumber;

    Input_File : Ada.Text_IO.File_Type;

    function Cost (Content : NumVector.Vector; Position : Natural) return Natural is
        Sum : Natural := 0;
    begin
        for E of Content loop
            declare
                Steps : Natural := abs (Integer(E) - Integer(Position));
                Costs : Natural := (Steps**2 + Steps) / 2;
            begin
                Sum := Sum + Costs;
                --  Ada.Text_IO.Put_Line ("From " & Natural'Image (E) & " to " & Natural'Image (Position) & " costs: " & Natural'Image (Costs));
            end;
        end loop;

        return Sum;
    end Cost;

begin
    Ada.Text_IO.Open (Input_File, Ada.Text_IO.In_File, Ada.Command_line.Argument(1));
    declare
        FileContent : String := Ada.Text_IO.Get_Line (Input_File);
        Parsed : NumVector.Vector := ParseFileContent (FileContent);
        Min : Natural := Natural'Last;
        Max : Natural := 0;
        Position : Natural := NumVector.Element (Parsed.First);
    begin
        --  Parsed.Iterate (PrintNumber'Access);
        --  Ada.Text_IO.Put_Line ("");

        for E of Parsed loop
            if E > Max then
                Max := E;
            end if;
        end loop;

        for I in 0 .. Max loop
            --  Ada.Text_IO.Put_Line ("Determining cost of " & Natural'Image (I));
            declare
                Costs : Natural := Cost(Parsed, I);
            begin
                if Costs < Min then
                    Min := Costs;
                    Position := I;
                end if;
            end;
        end loop;

        Ada.Text_IO.Put_Line ("Position: " & Natural'Image (Position) & "; Cost: " & Natural'Image (Min));
    end;
end Star2;
