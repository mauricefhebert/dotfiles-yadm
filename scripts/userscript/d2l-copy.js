// ==UserScript==
// @name        D2L Copy/Paste Data Button
// @namespace   Violentmonkey Scripts
// @match       *://coursebuilder.centrefran.co/*
// @grant       none
// @version     1.3
// @author      Mauricefh
// @description 2024-09-25 09 h 49 min 53 s
// ==/UserScript==

let executed = false;
let retryCount = 0;
const maxRetries = 5;

async function main() {
  if (executed) return; // Ensure this runs only once
  executed = true;

  setTimeout(await getData, 500);
}

function injectButton() {
  const iframe = document.querySelector("#editorFrame");

  if (iframe) {
    const iframeDocument = iframe.contentDocument || iframe.contentWindow.document;

    // Locate the target button
    const targetButton = iframeDocument.querySelector("#btnVideoDuCours");
    if (targetButton) {
      // Create the new button
      const button = document.createElement("button");
      button.setAttribute('id', 'copyDataBtn')
      button.textContent = "Copy Data"; // Button text
      button.className = "btn btnNoir float-right mb-5 ml-4"; // Add necessary classes
      button.style.zIndex = "1000"; // Make sure it’s on top of other elements

      // Insert the button before the target button
      targetButton.parentNode.insertBefore(button, targetButton.nextSibling);

      // Add the click event listener to the new button
      button.addEventListener("click", main);
    } else {
      retryCount++;
      if (retryCount < maxRetries) {
        setTimeout(injectButton, 500); // Retry after 500ms
      } else {
        console.error("Failed to inject button after 5 attempts.");
      }
    }
  }
}

// Start the injection process
injectButton();

async function getData() {
  const iframeDocument = document.querySelector("#editorFrame").contentWindow.document;

  let questionTrame = iframeDocument.querySelector(".IntroJs1 > p").innerHTML;
  let imageQuestion = getImageNameWithExtWithoutSize(
    iframeDocument.querySelector(".col-12 > span > img").getAttribute("src")
  );
  let pistesData = [];
  let suggestionsData = [];

  let pistes = iframeDocument.querySelector(".IntroJs2").querySelectorAll(".background_vert");
  pistes.forEach((piste) => {
    let icon = getImageNameWithoutExt(
      piste.querySelector("img").getAttribute("src")
    );
    let content = piste.nextElementSibling.querySelector(".p10").innerHTML;

    pistesData.push({ icon, content });
  });

  let suggestions = iframeDocument.querySelectorAll(".hovercard");
  suggestions.forEach((suggestion) => {
    let href = suggestion.getAttribute("href");
    let text = suggestion.querySelector("span").innerHTML;
    let imgSrc = getImageNameWithExtWithoutSize(
      suggestion.querySelector("img").getAttribute("src")
    );

    suggestionsData.push({ href, text, imgSrc });
  });

  let writter = iframeDocument.createElement("div");
  writter.setAttribute("id", "iframe_data");

  // Create a simple HTML structure without tables
let html = "";
  html += "<table>";
  html += `<tr><td>${imageQuestion}</td></tr>`;
  html += `<tr><td>${questionTrame}</td></tr>`;
  for (let i = 0; i < 2; i++) {
    html += "<tr><td></td></tr>";
  }
  pistesData.forEach((piste) => {
    html += `<tr><td>${piste.icon}</td></tr>`;
    html += `<tr><td>${piste.content}</td></tr>`;
    html += "<tr><td></td></tr>";
  });
  suggestionsData.forEach((sugg) => {
    html += `<tr><td>${sugg.href}</td></tr>`;
    html += `<tr><td>${sugg.text}</td></tr>`;
    html += `<tr><td>${sugg.imgSrc}</td></tr>`;
  });

  writter.innerHTML = html;

  iframeDocument.body.prepend(writter);

  // Copy content as HTML
  await copyContent(writter, true);

  // Clean up the temporary element
  writter.remove();
}

// Helper functions
function getImageName(url) {
  const match = /[\\/]+([^\\/]+)$/.exec(url);
  if (match) return match[1];
}
function getImageNameWithoutExt(url) {
  return getImageName(url).split(".").slice(0, -1).join(".");
}
function getImageNameWithExtWithoutSize(url) {
  const splitedName = getImageName(url).split(".");
  const ImageExt = splitedName[splitedName.length - 1];
  let ImageName = splitedName.slice(0, -1).join(".");
  const splitedImageName = ImageName.split("_");
  if (splitedImageName.length > 1)
    ImageName = ImageName.split("_").slice(0, -1).join("_");
  return `${ImageName}.${ImageExt}`;
}

function disableCopyBtn() {
  const iframe = document.querySelector("#editorFrame");
  const iframeDocument = iframe.contentDocument || iframe.contentWindow.document;
  const button = iframeDocument.getElementById("copyDataBtn");
  if (!button) {
    console.error("Button not found in iframe!");
    return;
  }
  button.removeEventListener("click", main);
  button.setAttribute('disabled', true);
  button.innerText = "Copied!";
  button.style.backgroundColor = 'green';
  button.style.cursor = 'default';
}

const observer = new MutationObserver(() => {
  const button = document.getElementById("copyDataBtn");
  if (button) {
    console.log("Button found!");
    observer.disconnect(); // Stop observing after finding the button
  }
});

// Start observing the body for changes
observer.observe(document.body, { childList: true, subtree: true });

async function copyContent(html, useBlob = false) {
  try {
    if (useBlob) {
      const blob = new Blob([html.innerHTML], { type: "text/html" });
      const clipboardItem = new ClipboardItem({ "text/html": blob });
      await navigator.clipboard.write([clipboardItem]);
      disableCopyBtn();
    } else {
      await navigator.clipboard.writeText(html.innerText);
      disableCopyBtn();
    }
    // Successfully copied to clipboard
  } catch (err) {
    console.error("Failed to copy: ", err);
    // Handle the error
  }
}
