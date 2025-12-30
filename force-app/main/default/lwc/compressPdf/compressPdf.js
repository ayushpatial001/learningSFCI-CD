import { LightningElement, track } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';

export default class PdfLibCompress extends LightningElement {
    @track isButtonDisabled = true; 
    file; 
    pdfLibLoaded = false;

    renderedCallback() {
        if (this.pdfLibLoaded) { 
            return; 
        }
        loadScript(this, pdfLib)
            .then(() => {
                if (window.PDFLib) {
                    this.pdfLibLoaded = true; 
                    console.log('pdf-lib loaded successfully'); 
                } else {
                    window.PDFLib = window.pdfLib; 
                    this.pdfLibLoaded = true; 
                    console.log('pdf-lib loaded successfully and assigned globally'); 
                }
            })
            .catch(error => { 
                console.error('Error loading pdf-lib:', error); 
            }); 
    }

    handleFileChange(event) { 
        this.file = event.target.files[0];
        if (this.file) { 
            console.log('File selected:', this.file);
            this.compressAndDownloadFile(this.file); 
        }
    }

    async compressAndDownloadFile(file) { 
        try { 
            const reader = new FileReader();
            reader.onload = async () => { 
                const uint8Array = new Uint8Array(reader.result); 
                console.log('File read successfully:', uint8Array);
                const pdfDoc = await window.PDFLib.PDFDocument.load(uint8Array); 
                console.log('PDF loaded successfully:', pdfDoc);  

                // Subset fonts (if the library supports it directly)
                // Note: pdf-lib doesn't provide direct font subsetting, so we skip this step

                // Remove redundant info (e.g., unnecessary metadata and unused resources)
                pdfDoc.cleanup(); // Removes unused objects
                pdfDoc.setTitle(''); // Remove title
                pdfDoc.setAuthor(''); // Remove author
                pdfDoc.setSubject(''); // Remove subject
                pdfDoc.setKeywords([]); // Remove keywords
                pdfDoc.setProducer(''); // Remove producer
                pdfDoc.setCreator(''); // Remove creator

                const pdfBytes = await pdfDoc.save({ useObjectStreams: true, updateFieldAppearances: false });
                
                console.log('PDF compressed successfully'); 
                
                // Create a Blob for the compressed PDF and trigger download 
                const blob = new Blob([pdfBytes], { type: 'application/pdf' }); 
                console.log('Blob created:', blob); 
                const link = document.createElement('a'); 
                link.href = URL.createObjectURL(blob); 
                link.download = 'compressed.pdf'; 
                link.click(); 
                console.log('Download link clicked'); 
                
                // Log the file size before and after compression 
                console.log('Original file size (bytes):', file.size);
                console.log('Compressed file size (bytes):', blob.size); 
            };
            reader.readAsArrayBuffer(file); 
        } catch (error) { 
            console.error('Error compressing the PDF:', error); 
        } 
    }
}