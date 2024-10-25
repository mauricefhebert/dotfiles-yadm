// ==UserScript==
// @name        format all
// @namespace   Violentmonkey Scripts
// @match       https://conan.cforp.ca/course/*
// @grant       none
// @version     1.3
// @author      Mauricefh
// @description 2024-09-27 11 h 51 min 01 s
// ==/UserScript==

let buttonInjected = false;  // Track if the button is already injected
let jsonBtnMoved = false;    // Track if the jsonBtn is already moved

function injectButton() {
  const container = document.getElementsByClassName("page-header")[0];  // Select the first element
  const div = document.createElement("div");
  div.setAttribute('id', 'header-btn-container');

  if (container) {
    // Check if the button already exists, avoid duplicates
    if (!document.querySelector("#formatAllButton")) {
      const button = document.createElement("button");
      button.id = "formatAllButton";  // Assign an ID to the button to avoid duplicates
      button.innerText = "Format All";
      button.classList.add('v-btn', 'v-btn--elevated', 'v-theme--light', 'bg-brown-darken-3', 'v-btn--density-default', 'v-btn--size-default', 'v-btn--variant-elevated', 'me-3');
      button.addEventListener("click", formatAll);

      div.appendChild(button);
      container.appendChild(div);  // Append the button to the container
      buttonInjected = true;  // Set the flag to avoid injecting again
    }
  } else {
    console.error("No page-header element found");
  }
}

function formatHeader() {
  const header = document.getElementsByClassName("page-header")[0];
  const div = document.getElementById("header-btn-container");

  if (header && div && !jsonBtnMoved) {
    const jsonBtn = header.querySelector('[type="button"]');
    if (jsonBtn && !div.contains(jsonBtn)) {  // Check if jsonBtn is not already in the div
      div.appendChild(jsonBtn);  // Move the jsonBtn to the div
      jsonBtnMoved = true;       // Set the flag to avoid moving again
    }
  }
}

function formatAll() {
  // Loop through all Monaco Editor instances
  document.querySelectorAll('[role="code"]').forEach((editorElement, index) => {
    // Access the Monaco editor instance
    let editorInstance = monaco.editor.getEditors().find(editor => editor.getDomNode() === editorElement);

    if (editorInstance) {
      // Focus the editor
      editorInstance.focus();

      // Trigger the formatting action ('Shift+Alt+F' equivalent)
      editorInstance.trigger('keyboard', 'editor.action.formatDocument', null);
    }
  });
}

// Function to observe changes in the DOM and trigger button injection
function observeDOMChanges() {
  const observer = new MutationObserver(mutations => {
    mutations.forEach(mutation => {
      if (mutation.addedNodes.length > 0) {
        // Check if 'v-container' or relevant nodes are added
        const container = document.getElementsByClassName("v-container")[0];
        const header = document.getElementsByClassName("page-header")[0];

        // Inject button only if not already done
        if (container && !buttonInjected) {
          console.log("v-container found. Injecting button.");
          injectButton();
        }

        // Call formatHeader when the page header exists and jsonBtn hasn't been moved
        if (header && !jsonBtnMoved) {
          formatHeader();
        }
      }
    });
  });

  // Start observing the document body for added/removed nodes
  observer.observe(document.body, { childList: true, subtree: true });
}

// Start observing the DOM for changes
setTimeout(observeDOMChanges, 100);
