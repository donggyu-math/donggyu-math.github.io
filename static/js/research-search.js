(function () {
  function normalize(value) {
    return value.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").trim().replace(/\s+/g, " ");
  }

  function updateSearch(root) {
    var input = root.querySelector("[data-search-input]");
    var items = Array.prototype.slice.call(root.parentElement.querySelectorAll("[data-search-item]"));
    var count = root.querySelector("[data-search-count]");
    var empty = root.parentElement.querySelector("[data-search-empty]");
    var terms = normalize(input.value).split(" ").filter(Boolean);
    var visible = 0;

    items.forEach(function (item) {
      var text = normalize(item.getAttribute("data-search-text") || "");
      var match = terms.every(function (term) {
        return text.indexOf(term) !== -1;
      });
      item.hidden = !match;
      if (match) visible += 1;
    });

    if (count) {
      count.textContent = terms.length ? visible + " papers found" : "Showing all " + items.length + " papers";
    }
    if (empty) {
      empty.hidden = visible !== 0;
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-search-root]").forEach(function (root) {
      var input = root.querySelector("[data-search-input]");
      if (!input) return;
      input.addEventListener("input", function () {
        updateSearch(root);
      });
      updateSearch(root);
    });
  });
})();
