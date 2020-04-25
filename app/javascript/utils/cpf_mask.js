import Inputmask from "inputmask";

const addCpfMask = () => {
  const cpfInput = document.getElementsByClassName("cpf_input");

  Inputmask({
    mask: "999.999.999-99",
    jitMasking: true
  }).mask(cpfInput);
};

$(document).ready(addCpfMask);
