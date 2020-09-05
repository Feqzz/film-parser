with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Text_IO;

package Parser is

   	function GetImdbMovieId (Var : Ada.Strings.Unbounded.Unbounded_String) return Ada.Strings.Unbounded.Unbounded_String;
   
   	function GetRating (Var : Ada.Strings.Unbounded.Unbounded_String) return Integer;
   
end Parser;
