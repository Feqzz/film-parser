package body Json is
   
   F : Ada.Text_IO.File_Type;
   Now : Ada.Calendar.Time := Ada.Calendar.Clock;
   OutputFileName : String := "films-watched.json";

   ----------------
   -- AppendFilm --
   ----------------

   procedure AppendFilm (title, year, score, imdb : String) is
   begin
      Ada.Text_IO.Open(F, Ada.Text_IO.Append_File, OutputFileName);
      Ada.Text_IO.Put_Line(F, "        {");
      
      Ada.Text_IO.Put(F, "         ""title"": """);
      Ada.Text_IO.Put(F, title);
      Ada.Text_IO.Put(F, """,");
      Ada.Text_IO.New_Line(F);
      
      Ada.Text_IO.Put(F, "         ""year"": """);
      Ada.Text_IO.Put(F, year);
      Ada.Text_IO.Put(F, """,");
      Ada.Text_IO.New_Line(F);
      
      Ada.Text_IO.Put(F, "         ""score"": """);
      Ada.Text_IO.Put(F, score);
      Ada.Text_IO.Put(F, """,");
      Ada.Text_IO.New_Line(F);
      
      Ada.Text_IO.Put(F, "         ""imdb"": """);
      Ada.Text_IO.Put(F, imdb);
      Ada.Text_IO.Put(F, """");
      Ada.Text_IO.New_Line(F);
      
      Ada.Text_IO.Put_Line(F, "        },");
      Ada.Text_IO.Close(F);
      
   end AppendFilm;

   ----------
   -- Init --
   ----------
   
   procedure Init is
   begin
      Ada.Text_IO.Create(F, Ada.Text_IO.Out_File, OutputFileName);
      Ada.Text_IO.Put_Line(F, "{");
      Ada.Text_IO.Put(F, "  ""name"": ""Films watched");
      Ada.Text_IO.Put(F, Integer'Image(Ada.Calendar.Day(Now)));
      Ada.Text_IO.Put(F, Integer'Image(Ada.Calendar.Month(Now)));
      Ada.Text_IO.Put(F, Integer'Image(Ada.Calendar.Year(Now)));
      Ada.Text_IO.Put(F, """,");
      Ada.Text_IO.New_Line(F);
      Ada.Text_IO.Put_Line(F, "  ""films"": [");
      Ada.Text_IO.Close(F);
   end Init;

   -----------
   -- Close --
   -----------
   
   procedure Close is
   begin
      Ada.Text_IO.Open(F, Ada.Text_IO.Append_File, OutputFileName);
      Ada.Text_IO.Put_Line(F, "  ]");
      Ada.Text_IO.Put_Line(F, "}");
      Ada.Text_IO.Close(F);
   end Close;

end Json;
