use [Library]
go 

--create trigger Library_trigger on S_Cards
--after update 
--as
--Begin
-- if update(date_in) and update(date_out)
-- begin
-- update Book
-- set quantity +=1 
-- from Book b 
-- inner join inserted i on b.id = i.id_book
-- end
--END

create trigger Dont_give_book on S_Cards
instead of insert 
as 
BEGIN
 Set nocount on
 if (select COUNT(*) from S_Cards where id_student in (select id_student from inserted)and date_in is null)>3
 begin
 print 'јйм сорри , вы не можете вз€ть больше 3 книг !!'
 rollback tran 
 end
 else
 begin
 insert into S_Cards(id_student,id_book,date_out,id_librarian)
 select id_student,id_book,date_out,id_librarian
 from inserted
 end
END