CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED vendas.imageutils AS
import java.awt.image.BufferedImage;
  import javax.imageio.ImageIO;
  import java.io.ByteArrayInputStream;
  import java.io.IOException;
  import java.sql.Blob;
  import java.sql.SQLException;
  import java.lang.*;
  import java.sql.*;
  import java.io.*;
  import oracle.sql.*;
  import java.awt.Graphics2D;
  import java.awt.image.BufferedImage;
  import java.io.ByteArrayInputStream;
  import java.io.ByteArrayOutputStream;
  import java.io.InputStream;
  import java.sql.Blob;
  import javax.imageio.ImageIO;
  import java.awt.Image;
  import java.awt.Color;
  import oracle.jdbc.driver.*;
  import com.sun.image.codec.jpeg.JPEGCodec;

  public class ImageUtils {
      public static int getWidth(Blob blob) throws SQLException, IOException {
        // Lê o blob em um array de bytes
        byte[] imageBytes = blob.getBytes(1, (int) blob.length());
        ByteArrayInputStream inputStream = new ByteArrayInputStream(imageBytes);
        BufferedImage image = ImageIO.read(inputStream);
        int width = image.getWidth();

        return width;
    }

      public static int getHeight(Blob blob) throws SQLException, IOException {
        // Lê o blob em um array de bytes
        byte[] imageBytes = blob.getBytes(1, (int) blob.length());
        ByteArrayInputStream inputStream = new ByteArrayInputStream(imageBytes);
        BufferedImage image = ImageIO.read(inputStream);
        int height = image.getHeight();

        return height;
    }

    public static java.sql.Blob resizeBLOBjpg(java.sql.Blob img, int newW, int newH)
     {
      try
         {


          byte[] newdata = img.getBytes(1L, (int)img.length());
          newdata = scaleJPG(newdata, newW, newH);

          oracle.jdbc.OracleConnection conn = (oracle.jdbc.OracleConnection)new OracleDriver().defaultConnection();
          java.sql.Blob retBlob = conn.createBlob();

          try
             {
              java.io.OutputStream outStr = retBlob.setBinaryStream(0);
              outStr.write(newdata, 0, newdata.length);
              outStr.flush();
              outStr.close();
             }
          catch (IOException ioe)
               {
                System.out.println("IO Error trying to write the outputstream.");
                ioe.printStackTrace();
               }

          return retBlob;
         }
      catch (SQLException ex)
           {
            System.out.println("SQLException Error.");
            ex.printStackTrace();
           }
      return img;
     }

     public static byte[]  scaleJPG(byte[] fileData, int width, int height)
     {
      double newW;
      double newH;

      ByteArrayInputStream in = new ByteArrayInputStream(fileData);
      try
         {

         BufferedImage img = JPEGCodec.createJPEGDecoder(in).decodeAsBufferedImage();

        // BufferedImage img = ImageIO.read(in);
        // weinberger 20220801 ImageIO can not handle all jpeg
       //  BufferedImage img = JPEGCodec.createJPEGDecoder(in).decodeAsBufferedImage();

          if(height == 0)
            height = 100;

          if(width == 0)
            width = 100;

          //Figure new Width and Height with Aspect Ratio
          double imgW = img.getWidth();
          double imgH = img.getHeight();

          if(imgH>imgW)
            {
             newW = (imgW/imgH)*width;
             newH = height;
            }
          else
            {
             newH = (imgH/imgW)*height;
             newW = width;
            }

          Image scaledImage = img.getScaledInstance((int)newW, (int)newH, Image.SCALE_SMOOTH);
          BufferedImage imageBuff = new BufferedImage((int)newW, (int)newH, BufferedImage.TYPE_INT_RGB);
          imageBuff.getGraphics().drawImage(scaledImage, 0, 0, new Color(0,0,0), null);

          ByteArrayOutputStream buffer = new ByteArrayOutputStream();

          ImageIO.write(imageBuff, "jpg", buffer);
          return buffer.toByteArray();
         }
       catch (IOException e)
            {
             //throw new ApplicationException("IOException in scale");
             e.printStackTrace();
            }
      return fileData;
     }


     public static java.sql.Blob resizeBLOBpng(java.sql.Blob img, int newW, int newH)
     {
      try
         {


          byte[] newdata = img.getBytes(1L, (int)img.length());
          newdata = scalePNG(newdata, newW, newH);

          oracle.jdbc.OracleConnection conn = (oracle.jdbc.OracleConnection)new OracleDriver().defaultConnection();
          java.sql.Blob retBlob = conn.createBlob();

          try
             {
              java.io.OutputStream outStr = retBlob.setBinaryStream(0);
              outStr.write(newdata, 0, newdata.length);
              outStr.flush();
              outStr.close();
             }
          catch (IOException ioe)
               {
                System.out.println("IO Error trying to write the outputstream.");
                ioe.printStackTrace();
               }

          return retBlob;
         }
      catch (SQLException ex)
           {
            System.out.println("SQLException Error.");
            ex.printStackTrace();
           }
      return img;
     }

     public static byte[]  scalePNG(byte[] fileData, int width, int height)
     {
      double newW;
      double newH;

      ByteArrayInputStream in = new ByteArrayInputStream(fileData);
      try
         {

         BufferedImage img = ImageIO.read(in);


          if(height == 0)
            height = 100;

          if(width == 0)
            width = 100;

          //Figure new Width and Height with Aspect Ratio
          double imgW = img.getWidth();
          double imgH = img.getHeight();

          if(imgH>imgW)
            {
             newW = (imgW/imgH)*width;
             newH = height;
            }
          else
            {
             newH = (imgH/imgW)*height;
             newW = width;
            }

          Image scaledImage = img.getScaledInstance((int)newW, (int)newH, Image.SCALE_SMOOTH);
          BufferedImage imageBuff = new BufferedImage((int)newW, (int)newH, BufferedImage.TYPE_INT_RGB);
          imageBuff.getGraphics().drawImage(scaledImage, 0, 0, new Color(0,0,0), null);

          ByteArrayOutputStream buffer = new ByteArrayOutputStream();

          ImageIO.write(imageBuff, "png", buffer);
          return buffer.toByteArray();
         }
       catch (IOException e)
            {
             //throw new ApplicationException("IOException in scale");
             e.printStackTrace();
            }
      return fileData;
     }


}
/

