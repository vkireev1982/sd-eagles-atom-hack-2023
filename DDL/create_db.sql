DROP TABLE IF EXISTS public.companies CASCADE;
--компании = участники + заявители
 CREATE TABLE companies (
   id VARCHAR(10),
   name VARCHAR(255),
   address VARCHAR(255),
--    organizationName VARCHAR(255),
   phone VARCHAR(255),
   email VARCHAR(255)
 );

DROP TABLE IF EXISTS public.tenders CASCADE;
--тендеры 
 CREATE TABLE tenders (
   id VARCHAR(10),
   cgn VARCHAR(255) NOT NULL,
   topic VARCHAR(512),
   createdat  DATE,
   --closetAt TIMESTAMP NOT NULL,
   --projectName TEXT NOT NULL,
   description TEXT,
   otherObligations TEXT,
   --organizerId INT NOT NULL,
   supplierId INT,
   price VARCHAR(255)
 );

DROP TABLE IF EXISTS public.tenders_companies CASCADE;
 CREATE TABLE tenders_companies (
   id VARCHAR(10),
   id_tender VARCHAR(10),
   id_company VARCHAR(10),
   is_main BOOLEAN
 );

DROP TABLE IF EXISTS public.works CASCADE;
  CREATE TABLE works (
   id VARCHAR(10),
--    tenderId VARCHAR(10),
   title VARCHAR(255),
   workType VARCHAR(255)
 );

DROP TABLE IF EXISTS public.tenders_works CASCADE;
 CREATE TABLE tenders_works (
   id VARCHAR(10),
   id_tender VARCHAR(10) ,
   id_work VARCHAR(10) ,
   price VARCHAR(255)
 );


--  CREATE TABLE works (
--    id SERIAL PRIMARY KEY,
--    title VARCHAR(255) NOT NULL,
--    type VARCHAR(255)
--  );
--  ALTER TABLE tenders
--  ADD FOREIGN KEY (organizerId) REFERENCES companies (id),
--  ADD FOREIGN KEY (supplierId) REFERENCES companies (id);
--  ALTER TABLE tenders_participants
--  ADD FOREIGN KEY (tenderId) REFERENCES tenders (id),
--  ADD FOREIGN KEY (participantId) REFERENCES companies (id);
--  ALTER TABLE tenders_works
--  ADD FOREIGN KEY (tenderId) REFERENCES tenders (id),
--  ADD FOREIGN KEY (workId) REFERENCES works (id),
--  ADD FOREIGN KEY (companyId) REFERENCES companies (id);

-- Закупки
-- ID
-- Дата создания
-- Название проекта
-- Номер закупик (CGN): CGN-20190906004
-- Описание проекта nullable
-- Другие обязательства nullable
-- Организатор: (id компании)
-- Поставщик: (id компании, которая реализовала), поле nullable (если указано, то закупка закрыта, победитель выбран)
-- Цена (nullable, string с валютой и значением), текущая


-- Закупки_Участники
-- ID
-- Закупка id
-- Участник id (id компании)


-- Компании
-- ID
-- Имя участника
-- Адрес nullable
-- Организация nullable
-- Телефон nullable
-- Электронная почта nullable