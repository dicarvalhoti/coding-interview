import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";
import Swal from "sweetalert2";

// Connects to data-controller="turbo"
export default class extends Controller {
  static values = ["companyid"];
  initialize() {
    if (this.element.getAttribute("data-method") === "delete") {
      this.element.setAttribute("data-action", "click->turbo#delete");
    } 
    }

    delete(e) {
        e.preventDefault();
        const csrfToken = document.getElementsByName("csrf-token")[0].content;
        const Toast = Swal.mixin({
          toast: true,
          position: "top-end",
          showConfirmButton: false,
          timer: 3000,
          timerProgressBar: true,
        });
        this.message = this.element.getAttribute("data-confirmar");
        this.text = this.element.getAttribute("data-text");
        this.url = this.element.getAttribute("href");

        Swal.fire({
            title: this.message || "Delete Data",
            text: this.text || "",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#4EBB30",
            confirmButtonText: "Yes, sure!",
            cancelButtonText: "No, keep it that way!",
          }).then((result) => {
            if (result.isConfirmed) {
              fetch(this.url, {
                method: "delete",
                headers: {
                  Accept: "text/vnd.turbo-stream.html",
                  "X-CSRF-Token": csrfToken,
                },
              })
                .then((r) => r.text())
               .then((html) => Turbo.renderStreamMessage(html))
               
      
              Toast.fire({
                icon: "warning",
                title: "Data deleted successfully!",
              });
            }
          });
    }
  }