with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Text_IO;

package Parser is

   	function getImdbMovieId (Var : Ada.Strings.Unbounded.Unbounded_String) return Ada.Strings.Unbounded.Unbounded_String;
   
   	function getRating (Var : Ada.Strings.Unbounded.Unbounded_String) return Integer;

end Parser;
