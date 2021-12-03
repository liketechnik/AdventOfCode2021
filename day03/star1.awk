BEGIN { FS="" }

function binary_to_decimal(str, expo, res, i) {
    expo=length(str) 
    for (i=1; i<=length(str); ++i) {
        if (substr(str,i,1) == "1") {
            res+=2^(expo - i) # first char has highest value, while last has lowest...
        }
    }

    return res
}

{
    for (i=1; i<=NF; ++i) {
        if ($i==1) {
            ones[i] += 1
        }
        if ($i==0) {
            zeroes[i] += 1
        }
    }
}

END {
    gamma_str=""
    for (i=1; i<=NF; ++i) {
        val=ones[i]>zeroes[i] ? "1" : "0"
        gamma_str = (gamma_str val)
    }
    gamma=binary_to_decimal(gamma_str)

    epsilon_str=""
    for (i=1; i<=NF; ++i) {
        val=ones[i]<zeroes[i] ? "1" : "0"
        epsilon_str = (epsilon_str val)
    }
    epsilon=binary_to_decimal(epsilon_str)

    printf("Gamma: %d, Epsioln: %d, Power Consumption: %d\n", gamma, epsilon, gamma * epsilon)
}
