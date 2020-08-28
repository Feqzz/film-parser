with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Command_Line;
with Ada.Integer_Text_IO;
with Ada.Task_Identification;

procedure Main is

   fileType : Ada.Text_IO.File_Type;
   fileName : Ada.Strings.Unbounded.Unbounded_String;
   counter: Integer;
   currentLine : Ada.Strings.Unbounded.Unbounded_String;
   currentArgument : Ada.Strings.Unbounded.Unbounded_String;

begin

   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("You forgot to pass the file as an argument!");
      Ada.Task_Identification.Abort_Task (Ada.Task_Identification.Current_Task);
   end if;

   counter := 0;

   fileName := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Command_Line.Argument(1));

   Ada.Text_IO.Open(fileType, Ada.Text_IO.In_File, Ada.Strings.Unbounded.To_String(fileName));

   loop
      exit when Ada.Text_IO.End_Of_File(fileType);

      currentLine := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Text_IO.Get_Line(fileType));
      if (Ada.Strings.Fixed.Index (Ada.Strings.Unbounded.To_String(currentLine), "<a class=""l_movie""") > 0) then
         --Found a movie!
         counter := counter + 1;

         for J in 1 .. Ada.Strings.Unbounded.Length (currentLine) loop
            if Ada.Strings.Unbounded.Element (currentLine, J) = '>' then

               for K in (J + 1) .. Ada.Strings.Unbounded.Length (currentLine) loop

                  if Ada.Strings.Unbounded.Element (currentLine, K) = '<' then
                     Ada.Text_IO.Put(" ");
                     for L in 1 .. 6 loop

                        Ada.Text_IO.Put(Ada.Strings.Unbounded.Element(currentLine, (K + 4 + L)));

                     end loop;
                     exit;
                  end if;
                  Ada.Text_IO.Put(Ada.Strings.Unbounded.Element(currentLine, K));
               end loop;

               Ada.Text_IO.New_Line;
               exit;

            end if;
         end loop;

      end if;

   end loop;

   if counter = 0 then
      Ada.Text_IO.Put("Sorry! Your file was not accepted.");
      Ada.Task_Identification.Abort_Task (Ada.Task_Identification.Current_Task);
   end if;

   Ada.Text_IO.Put("You have seen a total of ");
   Ada.Integer_Text_IO.Put(counter, 4);
   Ada.Text_IO.Put(" movies!");

   null;
end Main;

