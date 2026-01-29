package algorithm;

import java.math.BigInteger;

public class MHE_Encryptor {
    // Function to encrypt message with given keypair
     // Function to encrypt message with given keypair and return as String
    public static String encryptMessage(String message, PaillierKeyPair keyPair) {
        BigInteger plainNum = new BigInteger(message.getBytes());
        BigInteger cipher = keyPair.encrypt(plainNum);
        return cipher.toString();  // return encrypted BigInteger as String
    }

    // Function to decrypt cipher (given as String) with given keypair and return plaintext
    public static String decryptMessage(String cipherText, PaillierKeyPair keyPair) {
        BigInteger cipher = new BigInteger(cipherText);  // convert string back to BigInteger
        BigInteger decryptedNum = keyPair.decrypt(cipher);
        return new String(decryptedNum.toByteArray());
    }
    public static void main(String[] args) {
       
//        PaillierKeyPair user1 = new PaillierKeyPair();
//        PaillierKeyPair user2 = new PaillierKeyPair();
//
//        // Convert forensic text to number (simplified)
//        String forensicText = "Sample forensic test data";
//        BigInteger message = new BigInteger(forensicText.getBytes());
//
//        // Encrypt using User1's key
//        BigInteger encryptedUser1 = user1.encrypt(message);
//        System.out.println("Encrypted with User1 key: " + encryptedUser1);
//
//        // Encrypt the same plaintext with User2's key (simulating multi-key)
//        BigInteger encryptedUser2 = user2.encrypt(message);
//        System.out.println("Encrypted with User2 key: " + encryptedUser2);
//
//        // Decrypt individually
//        BigInteger decrypted1 = user1.decrypt(encryptedUser1);
//        BigInteger decrypted2 = user2.decrypt(encryptedUser2);
//
//        // Convert back to text
//        System.out.println("Decrypted (User1): " + new String(decrypted1.toByteArray()));
//        System.out.println("Decrypted (User2): " + new String(decrypted2.toByteArray()));
    }
}
