CREATE OR REPLACE PACKAGE vendas.img_utl IS
TYPE dimension_rec IS RECORD(
  height NUMBER,
  width NUMBER
  );
FUNCTION getWidth(p_blob IN BLOB)
RETURN number;

FUNCTION getHeight(p_blob IN BLOB)
RETURN NUMBER;

FUNCTION getMimeType(p_filename in varchar2)
return varchar2;

FUNCTION getFileFormat(p_filename in varchar2)
return varchar2;

FUNCTION resizeBLOBjpg(p_blob IN BLOB, p_width IN number, p_height IN NUMBER, formato varchar2)
RETURN Blob;

FUNCTION resizeBLOBpng(p_blob IN BLOB, p_width IN number, p_height IN NUMBER, formato varchar2)
RETURN Blob;

END;
/