CREATE OR REPLACE PACKAGE BODY vendas.img_utl IS

  FUNCTION getWidth(p_blob IN BLOB)
  return number as language java name 'ImageUtils.getWidth(java.sql.Blob) return Integer';

  FUNCTION getHeight(p_blob IN BLOB)
  return number as language java name 'ImageUtils.getHeight(java.sql.Blob) return Integer';

  FUNCTION getMimeType(p_filename IN VARCHAR2) RETURN VARCHAR2 is
        v_mime_type VARCHAR2(50);
        -- Mapa para trazer os mime types, para adicionar um novo basta colocar ele no mapa
        TYPE t_mime_map IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(50);
        c_mime_map t_mime_map := t_mime_map(
            'JPG'  => 'image/jpeg',
            'JPEG' => 'image/jpeg',
            'PNG'  => 'image/png',
            'WEBP' => 'image/webp',
            'BMP'  => 'image/bmp'
        );
   BEGIN
        -- Procura o mime baseado no formato do arquivo
        SELECT  c_mime_map(getFileFormat(p_filename))
        INTO    v_mime_type
        FROM    dual;

        RETURN v_mime_type;
        -- Caso não seja um arquivo válido a função retornará nula
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN NULL;
   END;

    FUNCTION getFileFormat(p_filename in varchar2) return varchar2 is
        wFormat     VARCHAR2(20);
        wPattern    varchar2(100) := '[^\.]*$';
    begin
        SELECT  UPPER(regexp_substr(p_filename, wPattern))
        INTO    wFormat
        FROM    dual;

        return wFormat;
    end;

  FUNCTION resizeBLOBjpg(p_blob IN BLOB, p_width IN number, p_height IN NUMBER, formato varchar2)
    RETURN Blob
    as
      language java
        name 'ImageUtils.resizeBLOBjpg(java.sql.Blob, int, int, java.lang.String) return oracle.sql.Blob';

  FUNCTION resizeBLOBpng(p_blob IN BLOB, p_width IN number, p_height IN NUMBER, formato varchar2)
    RETURN Blob
    as
      language java
        name 'ImageUtils.resizeBLOBpng(java.sql.Blob, int, int, java.lang.String) return oracle.sql.Blob';

END;
/

