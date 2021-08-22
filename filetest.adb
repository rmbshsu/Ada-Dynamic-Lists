--RWTextFileEx.adb
with Ada.Text_IO;
USE Ada.Text_IO;
--beware using this with tabs inside the .txt file
--as text_io will not hit EOF and will raise a runtime error

WITH Ada.Strings.Unbounded;
USE Ada.Strings.Unbounded;
WITH Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;
procedure FileTest is

   fileIn: File_Type;
   type Block_Collection is array (Positive range <>, positive range <>) of Unbounded_String;--CharBlock;
   Buffer : Character;
   Blocks: Block_Collection(1..14,1..6);
   TYPE Operation IS (IL, IR, DL, DR, DD, PA, PD);
   Command: Operation;
   Temp : Unbounded_String;
   CommandCode :String(1..2);

begin

   Ada.Text_IO.Open(File=>fileIn, Mode=> In_File, Name =>"DynListC.txt");

   FOR Row IN 1..14 LOOP
      for col in 1..6 loop
      Read_A_Single_Block:
         LOOP
         EXIT WHEN End_Of_File (fileIn);

         Get (File => fileIn,
            Item => Buffer);

         EXIT Read_A_Single_Block WHEN Buffer = ' ';

         Append (Source => Blocks(row,col),
            New_Item => Buffer);
         END LOOP Read_A_Single_Block;
      END LOOP;
    end loop;

   Ada.Text_IO.Close(File => FileIn);
   --print out the array of blocks of text
   --for testing to see if properly read into the array
   FOR Row IN 1..14 LOOP
      for col in 1..6 loop
      Put(Blocks(row,col));
         Put(" ");
      END LOOP;
      new_line;
   END LOOP;
   --Parser to pickup correct command, then execute it.
   FOR Row IN 2..14 LOOP
      Temp := Blocks(Row,1);
      CommandCode:= Ada.Strings.Unbounded.To_String(Temp);
      Command := Operation'Value(CommandCode);
   CASE Command IS
      WHEN IL   => Put("Do insertLeft.");
      WHEN IR   => Put("Do insertRight.");
      WHEN DL   => Put("Delete List.");
      WHEN DR   => Put("Delete Right.");
      WHEN DD   => Put("Delete Department");
      WHEN PA   => Put("Print All Departments.");
      WHEN PD   => Put("Print Department");
      WHEN OTHERS   =>NULL;
   end case;
   end loop;

end FileTest;