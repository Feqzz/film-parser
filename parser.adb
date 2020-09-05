package body Parser is

   --------------------
   -- GetImdbMovieId --
   --------------------

   function GetImdbMovieId (Var : Ada.Strings.Unbounded.Unbounded_String) return Ada.Strings.Unbounded.Unbounded_String is
      tmpString : Ada.Strings.Unbounded.Unbounded_String;
   begin
      for I in 39 .. Ada.Strings.Unbounded.Length (Var) loop

         if (Ada.Strings.Unbounded.Element (Var, I) = '"') then
            return tmpString;
         end if;

         Ada.Strings.Unbounded.Append(tmpString, Ada.Strings.Unbounded.Element (Var, I));

      end loop;
      return tmpString;

   end GetImdbMovieId;

   ---------------
   -- GetRating --
   ---------------

   function GetRating (Var : Ada.Strings.Unbounded.Unbounded_String) return Integer is
      tmpRating : Ada.Strings.Unbounded.Unbounded_String;
   begin
      for I in 1 .. Ada.Strings.Unbounded.Length (Var) loop

         if Ada.Strings.Unbounded.Element (Var, I) = '>' then

            if Ada.Strings.Unbounded.Element (Var, (I + 1)) = 'S' then
               return -1;
            end if;

            for J in (I + 1) .. Ada.Strings.Unbounded.Length (Var) loop

               if Ada.Strings.Unbounded.Element (Var, J) = '%' then
                  return Integer'Value (Ada.Strings.Unbounded.To_String (tmpRating));
               end if;
               Ada.Strings.Unbounded.Append(tmpRating, Ada.Strings.Unbounded.Element (Var, J));
            end loop;

         end if;
      end loop;

      Ada.Text_IO.Put_Line(Ada.Strings.Unbounded.To_String(tmpRating));
      return Integer'Value (Ada.Strings.Unbounded.To_String (tmpRating));

   end GetRating;

end Parser;
