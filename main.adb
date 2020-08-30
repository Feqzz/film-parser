with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Command_Line;
with Ada.Integer_Text_IO;
with Ada.Task_Identification;
with Parser;

procedure Main is

   fileType : Ada.Text_IO.File_Type;
   fileName : Ada.Strings.Unbounded.Unbounded_String;
   counter: Integer;
   currentLine : Ada.Strings.Unbounded.Unbounded_String;
   currentArgument : Ada.Strings.Unbounded.Unbounded_String;
   filmScore : Integer;
   showScore : Boolean := False;

begin

   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("You forgot to pass the file as an argument!");
      return;
   end if;
   
   for I in 1 .. (Ada.Command_Line.Argument_Count - 1) loop

      if Ada.Command_Line.Argument(I + 1) = "--score" then
         showScore := True;
      end if;
      
   end loop;
   
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

               exit;

            end if;
         end loop;
         
         
         if showScore then
            
            --Skips 6 lines in the HTML file.
            for I in 1 .. 6 loop
               currentLine := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Text_IO.Get_Line(fileType));
            end loop;

            if (Ada.Strings.Fixed.Index (Ada.Strings.Unbounded.To_String(currentLine), "<span id=") > 0) then
            
               Ada.Text_IO.Put(" ");
               filmScore := Parser.getRating(currentLine);
            
               if filmScore = -1 then
                  Ada.Text_IO.Put("Seen");
               else
                  Ada.Integer_Text_IO.Put(filmScore, 2);
               end if;
            
            end if;
            
         end if;
         
         Ada.Text_IO.New_Line;
         
      end if;

   end loop;

   if counter = 0 then
      Ada.Text_IO.Put("Sorry! Your file was not accepted.");
      return;
   end if;

   Ada.Text_IO.Put("You have seen a total of ");
   Ada.Integer_Text_IO.Put(counter, 4);
   Ada.Text_IO.Put(" movies!");

   null;
end Main;