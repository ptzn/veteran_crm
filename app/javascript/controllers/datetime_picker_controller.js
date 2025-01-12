import {Controller} from "@hotwired/stimulus"
import flatpickr from 'flatpickr';

export default class extends Controller {
  connect() {
    // prevent conflict with modal ESC handler
    // https://github.com/flatpickr/flatpickr/issues/1730#issuecomment-619233853
    //$('.modal[role=dialog]').removeAttr('tabindex')

    flatpickr(this.element, {
      allowInput: true,
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      altInput: true,
      altFormat: "d/m/Y H:i",
      time_24hr: true,
      minDate: Date.now()
    })
  }
}
