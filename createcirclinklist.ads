generic   -- in file CreateCircLinkList.ads
   TYPE DepartmentType IS PRIVATE;
   TYPE NameType IS PRIVATE;
   TYPE TitleType IS PRIVATE;
   WITH PROCEDURE Put(X:DepartmentType);
   WITH PROCEDURE Put(X:NameType);
   WITH PROCEDURE Put(X:TitleType);

PACKAGE CreateCircLinkList IS -- export the following behavior.
   --procedure AddToList(  listItem: in itemType );
   --procedure PrintList; -- Ada does allows but not require empty ( ).
   --PROCEDURE PrintList( Pt: IN Integer );
   procedure insertNodeLeft(deptName: in DepartmentType; empName: in NameType; title: in TitleType; ID: in Integer; Payrate: in Float);
   procedure insertNodeRight(deptName: in DepartmentType; empName: in NameType; title: in TitleType; ID: in Integer; Payrate: in Float);
   procedure deleteNodeLeft(deptName: in DepartmentType);
   procedure deleteNodeRight(deptName: in DepartmentType);
   procedure printAllDepartments;
   procedure printDepartment(deptName: in DepartmentType);
   --procedure DeleteList( pt: in integer );
--FUNCTION ListLength RETURN Integer;  -- Ada does allows but not require empty ( ).

End CreateCircLinkList;
