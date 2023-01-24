# Set the key and initialization vector (IV) for AES256 encryption
$key = [System.Convert]::FromBase64String("put your base64 key here")
$iv = [System.Convert]::FromBase64String("put your base64 iv here")

# Read the script to be encrypted
$script = Get-Content "path/to/script.ps1"

# Create a new AES256 encryption object
$aes = New-Object System.Security.Cryptography.AesCryptoServiceProvider
$aes.Key = $key
$aes.IV = $iv

# Create a new encryptor object
$encryptor = $aes.CreateEncryptor()

# Create a new memory stream to store the encrypted script
$ms = New-Object System.IO.MemoryStream

# Create a new crypto stream to encrypt the script
$cs = New-Object System.Security.Cryptography.CryptoStream($ms, $encryptor, [System.Security.Cryptography.CryptoStreamMode]::Write)

# Create a new stream writer to write the script to the crypto stream
$sw = New-Object System.IO.StreamWriter($cs)
$sw.Write($script)
$sw.Flush()
$cs.FlushFinalBlock()

# Close the crypto stream and the memory stream
$cs.Close()
$ms.Close()

# Encode the encrypted script with base64
$encodedScript = [Convert]::ToBase64String($ms.ToArray())

# Output the encoded script
$encodedScript
