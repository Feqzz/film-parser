with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Command_Line;
with Ada.Integer_Text_IO;
with Ada.Task_Identification;
with Parser;
with Json;

procedure Main is

   fileType : Ada.Text_IO.File_Type;
   fileName : Ada.Strings.Unbounded.Unbounded_String;
   counter: Integer;
   currentLine : Ada.Strings.Unbounded.Unbounded_String;
   currentArgument : Ada.Strings.Unbounded.Unbounded_String;
   filmScore : Integer;
   imdbId : Ada.Strings.Unbounded.Unbounded_String;
   filmTitle : Ada.Strings.Unbounded.Unbounded_String;
   filmYear : Ada.Strings.Unbounded.Unbounded_String;
   showScore : Boolean := False;
   showImdb : Boolean := False;
   showOnlyImdb: Boolean := False;
   writeToFile: Boolean := False;

begin

   if Ada.Command_Line.Argument_Count < 1 then
      Ada.Text_IO.Put_Line("You forgot to pass the file as an argument!");
      return;
   end if;

   for I in 1 .. (Ada.Command_Line.Argument_Count - 1) loop

      if Ada.Command_Line.Argument(I + 1) = "--score" then
         showScore := True;

      elsif Ada.Command_Line.Argument(I + 1) = "--imdb" then
         showImdb := True;

      elsif Ada.Command_Line.Argument(I + 1) = "--only_imdb" then
         showImdb := True;
         showOnlyImdb := True;

      elsif Ada.Command_Line.Argument(I + 1) = "--json" then
         writeToFile := True;

      else
         Ada.Text_IO.Put_Line("Invalid argument!");
         return;
      end if;

   end loop;

   counter := 0;

   if writeToFile then
      Json.Init;
   end if;

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
                     for L in 1 .. 4 loop
                        Ada.Strings.Unbounded.Append(filmYear, Ada.Strings.Unbounded.Element(currentLine, (K + 5 + L)));
                     end loop;
                     exit;
                  end if;
                  Ada.Strings.Unbounded.Append(filmTitle, Ada.Strings.Unbounded.Element(currentLine, K));
               end loop;

               exit;

            end if;
         end loop;
         
         imdbId := Parser.getImdbMovieId(currentLine);

         --Skips 6 lines in the HTML file.
         for I in 1 .. 6 loop
            currentLine := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Text_IO.Get_Line(fileType));
         end loop;

         if (Ada.Strings.Fixed.Index (Ada.Strings.Unbounded.To_String(currentLine), "<span id=") > 0) then
            filmScore := Parser.getRating(currentLine);
         end if;

         if writeToFile then
            Json.AppendFilm(Ada.Strings.Unbounded.To_String(filmTitle), Ada.Strings.Unbounded.To_String(filmYear), Integer'Image(filmScore), Ada.Strings.Unbounded.To_String(imdbId));
         end if;

         --------------
         -- Printing --
         --------------

         if showOnlyImdb then
            Ada.Text_IO.Put(Ada.Strings.Unbounded.To_String(imdbId));
         else
            Ada.Text_IO.Put(Ada.Strings.Unbounded.To_String(filmTitle));
            Ada.Text_IO.Put(" [");
            Ada.Text_IO.Put(Ada.Strings.Unbounded.To_String(filmYear));
            Ada.Text_IO.Put("]");

            if showScore then
               Ada.Text_IO.Put(" ");
               if filmScore = -1 then
                  Ada.Text_IO.Put("Seen");
               else
                  Ada.Integer_Text_IO.Put(filmScore, 2);
               end if;
            end if;

            if showImdb then
               Ada.Text_IO.Put(" ");
               Ada.Text_IO.Put(Ada.Strings.Unbounded.To_String(imdbId));
            end if;
         end if;
         
         Ada.Text_IO.New_Line;

         Ada.Strings.Unbounded.Delete(filmYear, 1, Ada.Strings.Unbounded.Length(filmYear));
         Ada.Strings.Unbounded.Delete(filmTitle, 1, Ada.Strings.Unbounded.Length(filmTitle));

      end if;

   end loop;

   if counter = 0 then
      Ada.Text_IO.Put("Sorry! Your file was not accepted.");
      return;
   end if;

   Ada.Text_IO.Put("You have seen a total of ");
   Ada.Integer_Text_IO.Put(counter, 4);
   Ada.Text_IO.Put(" movies!");

   Json.Close;

   null;
end Main;
