{ lib
, fetchFromGitHub
, runCommandNoCC
}:

let
  src = fetchFromGitHub {
    owner = "nix-community";
    repo = "rkwifibt";
    rev = "421b7dd8f3c67f66910710838a0be03f3575a3c9";
    sha256 = "175qcjfaz7nhpyh0hxiih53k3hly407lkpxgissvldghxrw01ccn";
  };
in
runCommandNoCC "pinebookpro-ap6256-firmware"
{
  meta = with lib; {
    license = licenses.unfreeRedistributable;
  };
} ''
  (PS4=" $ "; set -x
  cp ${src}/"BCM4345C5.hcd"               "BCM4345C5.hcd"
  cp ${src}/"fw_bcm43456c5_ag.bin"        "fw_bcm43456c5_ag.bin"
  cp ${src}/"brcmfmac43456-sdio.clm_blob" "brcmfmac43456-sdio.clm_blob"
  cp ${src}/"nvram_ap6256.txt"            "nvram_ap6256.txt"
  mkdir -p $out/lib/firmware/brcm
  # Bluetooth firmware
  install -Dm644 "BCM4345C5.hcd" -t "$out/lib/firmware/"
  install -Dm644 "BCM4345C5.hcd"    "$out/lib/firmware/brcm/BCM.hcd"
  install -Dm644 "BCM4345C5.hcd" -t "$out/lib/firmware/brcm/"
  # Wifi firmware
  install -Dm644 "nvram_ap6256.txt" -t         "$out/lib/firmware/"
  install -Dm644 "fw_bcm43456c5_ag.bin"        "$out/lib/firmware/brcm/brcmfmac43456-sdio.bin"
  install -Dm644 "brcmfmac43456-sdio.clm_blob" "$out/lib/firmware/brcm/brcmfmac43456-sdio.clm_blob"
  install -Dm644 "nvram_ap6256.txt"            "$out/lib/firmware/brcm/brcmfmac43456-sdio.radxa,rockpi4b.txt"
  install -Dm644 "nvram_ap6256.txt"            "$out/lib/firmware/brcm/brcmfmac43456-sdio.radxa,rockpi4c.txt"
  install -Dm644 "nvram_ap6256.txt"            "$out/lib/firmware/brcm/brcmfmac43456-sdio.pine64,pinebook-pro.txt"
  install -Dm644 "nvram_ap6256.txt"            "$out/lib/firmware/brcm/brcmfmac43456-sdio.pine64,rockpro64-v2.1.txt"
  )
''
