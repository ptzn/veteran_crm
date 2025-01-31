import { get } from '@rails/request.js'
import { Modal } from 'bootstrap'

const RemoteModal = {
  init: () => {
    document.addEventListener('click', (e) => {
      let element = e.target
      if( !element.classList.contains('remote-modal') ) {
        return
      }
      e.preventDefault()

      const url = element.getAttribute("href") || element.dataset.url
      RemoteModal.show(element.dataset.target, url, { cssClass: element.dataset.cssClass })

      return false
    })

    // $(document).on('hidden.bs.modal', '.modal-remote', function (e) {
    //   $(e.currentTarget).modal('dispose').remove();
    // })
  },

  show: (target, url, options) => {
    options = options || { cssClass: '' }

    let modalClass = "modal modal-remote modal-lg"
    if(options['cssClass']) modalClass += ` ${options['cssClass']}`

    let modal = `<div id='remote-modal' class='${modalClass}' tabindex='-1' role='dialog' data-target='${target}'></div`
    document.querySelector('#page-main').insertAdjacentHTML('beforeend', modal)

    get(url, {
      contentType: 'application/html',
      headers: {
        'X-Modal': '1'
      }
    }).then(response => {
      response.html.then(html => {
        let modalElm = document.getElementById('remote-modal')
        modalElm.innerHTML = html
        new Modal(modalElm).show()
      })
    }).catch( error => {
      console.log("error: " + error)
      document.getElementById('remote-modal').remove()
    })
  }
}

export default RemoteModal
