create or replace function saludar (
    p_nombre VARCHAR2
) return VARCHAR2 AS
LANGUAGE JAVA NAME
'Comunicar.saludar(java.lang.String) return java.lang.String';


create or replace function despedirse (
    p_nombre VARCHAR2
) return VARCHAR2 AS
LANGUAGE JAVA NAME
'Comunicar.despedirse(java.lang.String) return java.lang.String';