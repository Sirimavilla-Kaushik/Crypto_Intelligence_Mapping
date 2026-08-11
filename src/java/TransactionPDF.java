

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import connection.Dbconnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSet;

@WebServlet("/TransactionPDF")
public class TransactionPDF extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=transactions.pdf");

        try {
            OutputStream out = response.getOutputStream();
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, out);
            document.open();

            // Title
            Font fontTitle = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Transaction History", fontTitle);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" ")); // empty line

            // Table with 7 columns
            PdfPTable table = new PdfPTable(7);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);

            // Table headers
            String[] headers = {"Transaction ID", "Sender", "Receiver", "Amount", "Date", "Status", "Flagged"};
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h,
                        new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE)));
                cell.setBackgroundColor(new BaseColor(12, 110, 105));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }
// Font for table data (smaller)
Font fontData = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL); // 10pt font, smaller than headers

// Fetch DB records
Dbconnection db = new Dbconnection();
ResultSet rs = db.Select("SELECT * FROM transactions ORDER BY Date_Time ASC");

boolean hasData = false;
while (rs.next()) {
    hasData = true;
    table.addCell(new PdfPCell(new Phrase(String.valueOf(rs.getInt("T_Id")), fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getString("Sender_Address"), fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getString("Receiver_Address"), fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getDouble("ETH_Amount") + " ETH", fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getString("Date_Time"), fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getString("Status"), fontData)));
    table.addCell(new PdfPCell(new Phrase(rs.getInt("Flagged") == 1 ? "Flagged" : "Normal", fontData)));
}

if (!hasData) {
    PdfPCell noData = new PdfPCell(new Phrase("No transactions found!", fontData));
    noData.setColspan(7);
    noData.setHorizontalAlignment(Element.ALIGN_CENTER);
    table.addCell(noData);
}


            document.add(table);
            document.close();
            out.flush();
            out.close();

        } catch (DocumentException e) {
            throw new IOException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
