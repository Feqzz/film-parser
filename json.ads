with Ada.Text_IO;
with Ada.Calendar;
with Ada.Real_Time;
with Ada.Integer_Text_IO;

package Json is

   procedure AppendFilm (title, year, score, imdb : String);
   procedure Init;
   procedure Close;

end Json;
