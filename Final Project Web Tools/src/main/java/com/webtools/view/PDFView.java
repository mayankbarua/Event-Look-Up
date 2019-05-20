package com.webtools.view;

import java.awt.Color;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.webtools.Dao.BookingDAO;
import com.webtools.Dao.EventDAO;
import com.webtools.pojo.Booking;
import com.webtools.pojo.Event;

public class PDFView extends AbstractPdfView {

	private long bookingId;
	private EventDAO eventDao;
	private BookingDAO bookingDao;

	public PDFView(long bookingId) {
		this.bookingId = bookingId;
		bookingDao = new BookingDAO();
		eventDao = new EventDAO();
	}

	@Override
	protected void buildPdfDocument(Map<String, Object> model, com.lowagie.text.Document pdfdoc,
			com.lowagie.text.pdf.PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Font helvetica_15_grey = new Font(Font.TIMES_ROMAN, 15, Font.BOLDITALIC, Color.DARK_GRAY);
		Font helvetica_20_blue = new Font(Font.TIMES_ROMAN, 20, Font.BOLDITALIC, Color.BLUE);
		Font helvetica_12_black = new Font(Font.TIMES_ROMAN, 12, Font.ITALIC, Color.BLACK);

		Paragraph title = new Paragraph("Thankyou for Booking Event with us", helvetica_20_blue);

		Phrase producttitle = new Phrase("Please Find Below Details for Your Event");

		Booking booking = bookingDao.getBookingDetails(bookingId);
		Event event = eventDao.getDetail(booking.getEventId());

		PdfPTable table = new PdfPTable(2);
		table.setWidthPercentage(100.0f);
		table.setWidths(new float[] { 3.0f, 3.0f });
		table.setSpacingBefore(10);

		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(Color.WHITE);
		cell.setPadding(5);

		cell.setPhrase(new Phrase(" Event Name ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase(event.getEventName(), helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Event Date ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase("" + event.getEventDate(), helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Event Address ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase(
				event.getAddress() + ", " + event.getCity() + ", " + event.getState() + ", " + event.getZipCode(),
				helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Number Of Tikcets ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase("" + booking.getNumberOfTickets(), helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Booking Date ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase("" + booking.getBookingDate(), helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Booking Status ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase(booking.getBookingStatus(), helvetica_12_black));
		table.addCell(cell);

		cell.setPhrase(new Phrase(" Booking Reference Number ", helvetica_15_grey));
		table.addCell(cell);

		cell.setPhrase(new Phrase("" + booking.getBookingId(), helvetica_12_black));
		table.addCell(cell);

		pdfdoc.add(title);
		pdfdoc.add(producttitle);
		pdfdoc.add(table);
	}
}
