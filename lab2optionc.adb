WITH Ada.Text_IO;
USE Ada.Text_IO;  -- Created with AdaGuide.
WITH Ada.Unchecked_Deallocation;


PROCEDURE Lab2OptionC IS
   PACKAGE IIO IS NEW Ada.Text_IO.Integer_IO(Integer);
   USE IIO;
   PACKAGE FloatIO IS NEW Ada.Text_IO.Float_IO(Float);
   USE FloatIO;

   PROCEDURE MyPut (
         X : Float) IS
   BEGIN
      FloatIO.Put(X,2,2,0);
   END;

   TYPE DepartmentType IS
         (Sales,
          Crew,
          IT,
          Media,
          Accounting,
          NoDept);
   PACKAGE DeptTypeIO IS NEW Ada.Text_IO.Enumeration_IO(DepartmentType);
   USE DeptTypeIO;

   TYPE TitleType IS
         (Manager,
          Sales_Person,
          Designer,
          Programmer,
          Software_Engineer,
          Spokesperson,
          Pilot,
          Copilot,
          Scientist,
          MissionSpecialist,
          NoTitle);
   PACKAGE TitleTypeIO IS NEW Ada.Text_IO.Enumeration_IO(TitleType);
   USE TitleTypeIO;

   TYPE NameType IS
         (Bob,
          Mary,
          Sally,
          David,
          Marty,
          Vallerie,
          Sam,
          Joe,
          NoName);
   PACKAGE NameTypeIO IS NEW Ada.Text_IO.Enumeration_IO(NameType);
   USE NameTypeIO;

   TYPE EmpNode;
   TYPE EmpPt IS ACCESS EmpNode;

   TYPE EmpNode IS
      RECORD
         DeptName  : DepartmentType := NoDept;
         EmpName   : NameType       := NoName;
         Title     : TitleType      := NoTitle;
         IDin      : Integer        := 0;
         PayrateIn : Float          := 0.00;
         Next      : EmpPt          := NULL;
      END RECORD;

   TYPE DepartmentNode;
   TYPE DeptPt IS ACCESS DepartmentNode;

   TYPE DepartmentNode IS
      RECORD
         DeptName : DepartmentType;
         EmpName  : NameType;
         Num      : Integer        := 0;
         Next     : EmpPT          := NULL;
      END RECORD;


   PROCEDURE Free IS
   NEW Ada.Unchecked_Deallocation(EmpNode, EmpPt);
   Department : ARRAY (DepartmentType) OF DepartmentNode;
   PROCEDURE InsertNodeLeft (
         DeptNameIn : DepartmentType;
         EmpNameIn  : NameType;
         TitleIn    : TitleType;
         ID         : Integer;
         PayrateIn  : Float) IS
      Pt  : EmpPt;
      Pt2 : EmpPt;
   BEGIN
      Pt := NEW EmpNode'(DeptNameIn, EmpNameIn, TitleIn, ID, PayrateIN, NULL);
      IF( Department(DeptNameIn).Next = NULL ) THEN  -- empty list
         Pt.Next := Pt;
         Department(DeptNameIn).Next := Pt;
      ELSE
         Pt2:= Department(DeptNameIn).Next;
         WHILE Pt2.Next /= Department(DeptNameIn).Next LOOP
            Pt2:= Pt2.Next;
         END LOOP;
         Pt.Next := Department(DeptNameIn).Next;
         Pt2.Next := Pt;
         Department(DeptNameIn).Next := Pt;
      END IF;
      Department(DeptNameIn).Num := Department(DeptNameIn).Num + 1; -- track number in list
   END InsertNodeLeft;

   PROCEDURE InsertNodeRight (
         DeptNameIn : DepartmentType;
         EmpNameIn  : NameType;
         TitleIn    : TitleType;
         ID         : Integer;
         PayrateIn  : Float) IS
      Pt  : EmpPt;
      Pt2 : EmpPt;
   BEGIN
      Pt := NEW EmpNode'(DeptNameIn, EmpNameIn, TitleIn, ID, PayrateIN, NULL);
      IF (Department(DeptNameIn).Next = NULL ) THEN -- empty list same as left insert
         Pt.Next := Pt; --Set up circular list
         Department(DeptNameIn).Next := Pt; --new first node
      ELSE
         Pt2:= Department(DeptNameIn).Next;
         WHILE Pt2.Next /= Department(DeptNameIn).Next LOOP
            Pt2 := Pt2.Next;
         END LOOP;
         Pt2.Next := Pt;
         Pt.Next := Department(DeptNameIn).Next;
      END IF;
      Department(DeptNameIn).Num := Department(DeptNameIn).Num + 1;
   END InsertNodeRight;

   PROCEDURE DeleteNodeLeft (
         DeptNameIn : DepartmentType) IS
      Pt  : EmpPt;
      Pt2 : EmpPt;
   BEGIN
      IF (Department(DeptNameIn).Next = NULL) THEN
         Put("Cannot delete from an empty list! Abort due to underflow.");
      ELSE
         Pt2:= Department(DeptNameIn).Next;
         WHILE Pt2.Next /= Department(DeptNameIn).Next LOOP
            Pt2 := Pt2.Next;
         END LOOP;
         Pt := Department(DeptNameIn).Next;
         Department(DeptNameIn).Next:= Pt.Next;
         Pt2.Next:= Department(DeptNameIn).Next;
         Free(Pt);
      END IF;
      Department(DeptNameIn).Num := Department(DeptNameIn).Num - 1;
   END DeleteNodeLeft;

   PROCEDURE DeleteNodeRight (
         DeptNameIn : DepartmentType) IS
      Pt  : EmpPt;
      Pt2 : EmpPt;
   BEGIN
      IF (Department(DeptNameIn).Next = NULL) THEN
         Put("Cannot delete from an empty list! Abort due to underflow.");
      ELSE
         Pt:= Department(DeptNameIn).Next;
         Pt2:= Department(DeptNameIn).Next;
         WHILE Pt2.Next.Next /= Department(DeptNameIn).Next LOOP
            Pt2 := Pt2.Next;
         END LOOP;
         Pt:= Pt2;
         Pt2:= Pt2.Next;
         Pt.Next:= Department(DeptNameIn).Next;
         Free(Pt2);
      END IF;
      Department(DeptNameIn).Num := Department(DeptNameIn).Num - 1;
   END DeleteNodeRight;

   PROCEDURE DeleteDepartment (
         DeptNameIn : DepartmentType) IS
      Pt    : EmpPt;
      Pt2   : EmpPt;
      Index : Integer;
   BEGIN
      Index:= 1;
      IF Department(DeptNameIn).Next = NULL THEN
         Put("Cannot delete an empty department.");
      ELSE
         Pt:= Department(DeptNameIn).Next;
         Pt2:= Department(DeptNameIn).Next;
         WHILE Index < Department(DeptNameIn).Num LOOP
            Pt:= Pt.Next;
            Free(Pt2);
            Pt2:= Pt;
         END LOOP;
         Pt:= NULL;
         Department(DeptNameIn).Next := NULL;
      END IF;
   END DeleteDepartment;

   PROCEDURE PrintDepartment (
         DeptNameIn  : DepartmentType;
         FileTypeOut : File_Type) IS
      Pt : EmpPt;
   BEGIN
      IF(Department(DeptNameIn).Next = NULL) THEN
         Put(FileTypeOut,"Department is empty.");
      ELSE
         Pt:= Department(DeptNameIn).Next;
         FOR Index IN 1..Department(DeptNameIn).Num LOOP
            Put(FileTypeOut,"|");
            NameTypeIO.Put(FileTypeOut,Pt.EmpName);
            Put (FileTypeOut,",");
            TitleTypeIO.Put(FileTypeOut,Pt.Title);
            Put(FileTypeOut,",");
            Put(FileTypeOut,Pt.IDin);
            Put(FileTypeOut,",");
            Put(FileTypeOut,Pt.Payratein);
            Put(FileTypeOut,"|");
            Put(FileTypeOut,"->");
            IF(Pt.Next = Department(DeptNameIn).Next)THEN
               Put(FileTypeOut,"Print Complete.");
               Put(FiletypeOut, ASCII.LF);
            END IF;
            Pt:= Pt.Next;
         END LOOP;
      END IF;
   END PrintDepartment;

   --Writing this hurt my soul, but I could not get it to work otherwise
   PROCEDURE PrintAllDepartments (
         FileTypeOut : File_Type) IS
   BEGIN
      IF Department(Sales).Num =0 THEN
         Put(FileTypeOut,"Sales is empty.");
         Put(FiletypeOut, ASCII.LF);
      ELSE
         PrintDepartment(Sales,FileTypeOut);
      END IF;

      IF Department(Crew).Num =0 THEN
         Put(FileTypeOut,"Crew is empty.");
         Put(FiletypeOut, ASCII.LF);
      ELSE
         PrintDepartment(Crew,FileTypeOut);
      END IF;

      IF Department(IT).Num =0 THEN
         Put(FileTypeOut,"IT is empty.");
         Put(FiletypeOut, ASCII.LF);
      ELSE
         PrintDepartment(IT,FileTypeOut);
      END IF;

      IF Department(Media).Num = 0 THEN
         Put(FileTypeOut,"Media is empty.");
         Put(FiletypeOut, ASCII.LF);
      ELSE
         PrintDepartment(Media,FileTypeOut);
      END IF;

      IF Department(Accounting).Num = 0 THEN
         Put(FileTypeOut,"Accounting is empty.");
         Put(FiletypeOut, ASCII.LF);
      ELSE
         PrintDepartment(Accounting,FileTypeOut);
      END IF;
   END PrintAllDepartments;


   FileIn  : File_Type;
   FileOut : File_Type;
   TYPE Operation IS
         (IL,
          IR,
          DL,
          DR,
          DD,
          PA,
          PD);
   Command : Operation;
   PACKAGE OperationIO IS NEW Ada.Text_IO.Enumeration_IO(Operation);
   USE OperationIO;
   CodeArray  : ARRAY (1 .. 13) OF Operation;
   DeptArray  : ARRAY (1 .. 13) OF DepartmentType;
   NameArray  : ARRAY (1 .. 13) OF NameType;
   TitleArray : ARRAY (1 .. 13) OF TitleType;
   IDArray    : ARRAY (1 .. 13) OF Integer;
   PayArray   : ARRAY (1 .. 13) OF Float;

BEGIN


   BEGIN

      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");

      FOR Row IN 1..13 LOOP
         EXIT WHEN END_OF_FILE (Filein);
         Get(Filein, CodeArray(Row));
         Skip_Line(Filein);
      END LOOP;

      Ada.Text_IO.Close(File => FileIn);
      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");
      --Each loop below opens the file for the respective column,
      --and gets that information
      FOR Row IN 1..13 LOOP
         EXIT WHEN END_OF_FILE (Filein);
         Set_Col(FileIn,4);
         DeptTypeIO.Get(Filein, DeptArray(Row));
      END LOOP;

      Ada.Text_IO.Close(File => FileIn);
      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");

      FOR Index IN 1..13 LOOP
         EXIT WHEN End_Of_File (FileIn);
         Set_Col(FileIn, 11);
         NameTypeIO.Get(Filein, NameArray(Index));
      END LOOP;

      Ada.Text_IO.Close(File => FileIn);
      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");

      FOR Row IN 1..13 LOOP
         EXIT WHEN End_Of_File (Filein);
         Set_Col(FileIn,33);
         IIO.Get(Filein, IdArray(Row));
      END LOOP;

      Ada.Text_IO.Close(File => FileIn);
      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");

      FOR Row IN 1..13 LOOP
         EXIT WHEN End_Of_File (FileIn);
         Set_Col(Filein, 20);
         TitleTypeIO.Get(Filein, TitleArray(Row));
      END LOOP;
      NULL;

      Ada.Text_IO.Close(File => FileIn);
      Open(
         File => FileIn,
         Mode => In_File,
         Name => "DynListC.txt");

      FOR Row IN 1..13 LOOP
         EXIT WHEN End_Of_File(Filein);
         Set_Col(Filein, 38);
         FloatIO.Get(Filein, PayArray(Row));
      END LOOP;

      Close(File => FileIn);
      --Case Statement to read commands then execute them
      --and output to a .txt file
      Create(
         File => FileOut,
         Mode => Out_File,
         Name => "DepartmentLists.txt");
      FOR Index IN 1..13 LOOP
         Command:= CodeArray(Index);
         CASE Command IS
            WHEN IL   =>
               InsertNodeLeft(DeptArray(Index), NameArray(Index), TitleArray(Index), IDArray(Index), PayArray(Index));
            WHEN IR   =>
               InsertNodeRight(DeptArray(Index), NameArray(Index), TitleArray(Index), IDArray(Index), PayArray(Index));
            WHEN DL   =>
               DeleteNodeLeft(DeptArray(Index));
            WHEN DR   =>
               DeleteNodeRight(DeptArray(Index));
            WHEN DD   =>
               DeleteDepartment(DeptArray(Index));
            WHEN PA   =>
               PrintAllDepartments(FileOut);
            WHEN PD   =>
               PrintDepartment(DeptArray(Index),FileOut);
         END CASE;
      END LOOP;

      Close(FileOut);
   END;
END Lab2OptionC;