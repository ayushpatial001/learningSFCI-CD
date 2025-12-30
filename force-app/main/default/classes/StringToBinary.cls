public class StringToBinary {
    public static String toBinary(String input) {
        String binaryString = '';
        for (Integer i = 0; i < input.length(); i++) {
            // Get the ASCII value of the character
            Integer asciiValue = input.charAt(i);
            // Convert the ASCII value to binary
            String binaryChar = '';
            while (asciiValue > 0) {
                binaryChar = String.valueOf(Math.mod(asciiValue, 2)) + binaryChar;
                asciiValue = Math.floor(asciiValue / 2).intValue();
            }
            // Pad the binaryChar with leading zeros to ensure 8 bits for each character
            while (binaryChar.length() < 8) {
                binaryChar = '0' + binaryChar;
            }
            binaryString += binaryChar;
        }
        return binaryString;
    }
    
    public static void main() {
        String inputString = 'Hello';
        String binaryOutput = toBinary(inputString);
        System.debug('Binary Representation: ' + binaryOutput);
        StoreResultIntoBinary__c newRecord =  new StoreResultIntoBinary__c();
        newRecord.BinaryOuptut__c = binaryOutput;
        
        try{
            insert newRecord;
        }catch(Exception e){
            System.debug('this is not working'+e.getCause());
            System.debug('this is not working'+e.getMessage ());
            System.debug('this is not working'+e.getTypeName());
        }
    }
}