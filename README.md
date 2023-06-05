# Java-to-replace-some-ordimage-functionalities

Oracle PL/SQL Java Package - ImageUtils

This Oracle PL/SQL Java package provides a set of functions that can be used to replace some key functionalities from the decommissioned Ordimage object in Oracle. It offers convenient methods to handle image-related operations in a simpler manner.

## Functions
The ImageUtils package includes the following functions:

- getWidth: Retrieves the width of an image blob.
- getHeight: Retrieves the height of an image blob.
- getMimeType: Retrieves the mime type of a file based on its name.
- getFileFormat: Retrieves the file format from the file name.
- resizeBLOBjpg: Resizes JPG images given a blob and new height and width parameters.
- resizeBLOBpng: Resizes other types of images (non-JPG) given a blob and new height and width parameters.

## Usage
To utilize the ImageUtils package, follow these steps:

- Install the package in your Oracle database.
- Include the package in your PL/SQL code using the CREATE OR REPLACE PACKAGE statement.
- Invoke the desired function from the package in your code to perform the required image manipulation or retrieval.

Here's an example of how you can use the getWidth function:

```sql
DECLARE
  image_blob BLOB;
  width NUMBER;
BEGIN
  -- Assign the image blob to 'image_blob' variable.

  -- Call the getWidth function.
  width := ImageUtils.getWidth(image_blob);

  -- Use the retrieved width for further processing.
  -- ...
END;
```

## Contribution
Contributions to the ImageUtils package are welcome! If you find any issues or have suggestions for improvements, please submit an issue or pull request.

## Acknowledgements
The ImageUtils package was developed by me with the help of Lucas Ruiz and Carlos Amaral.

## Remarks
While the ImageUtils package provides a functional solution for image manipulations, it's important to note that the performance may not be optimal when compared to other solutions available in the market.

For more efficient and advanced image manipulation capabilities, we recommend considering alternative tools like Apex Media Extension or ImageMagick. These tools are specifically designed for handling image processing tasks and offer a wide range of features and optimizations for improved performance.
