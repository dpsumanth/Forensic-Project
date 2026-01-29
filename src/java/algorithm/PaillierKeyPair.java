package algorithm;

import java.math.BigInteger;
import java.security.SecureRandom;

public class PaillierKeyPair {
    public BigInteger p, q, n, nsquare, g, lambda;
    private int bitLength = 512;
    private SecureRandom random;

    public PaillierKeyPair() {
        random = new SecureRandom();
        p = new BigInteger(bitLength / 2, 100, random);
        q = new BigInteger(bitLength / 2, 100, random);
        n = p.multiply(q);
        nsquare = n.multiply(n);
        g = new BigInteger("2");
        lambda = p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE));
    }

    public BigInteger encrypt(BigInteger m) {
        BigInteger r = new BigInteger(bitLength, random);
        return g.modPow(m, nsquare).multiply(r.modPow(n, nsquare)).mod(nsquare);
    }

    public BigInteger decrypt(BigInteger c) {
        BigInteger u = g.modPow(lambda, nsquare).subtract(BigInteger.ONE).divide(n).modInverse(n);
        return c.modPow(lambda, nsquare).subtract(BigInteger.ONE).divide(n).multiply(u).mod(n);
    }
}
