var EndlessPage = Class.create({

  initialize: function (total_pages, url, default_pagination_id, spinner_id) {
    this.timer = null;
    this.current_page = 1;
    this.total_pages = total_pages;
    this.ajax_path = url;
    this.default_pagination = $(default_pagination_id);
    this.spinner = $(spinner_id);
    this.interval = 1000; // 1 second
    this.distance_to_bottom_offset = 200;
    
    // hide default pagination
    this.hideDefaultPagination();
    // start the listener
    this.startListener();
  },
  
  hideSpinner: function(){
    if(this.spinner) { this.spinner.hide() };
  },
  
  showSpinner: function(){
    if(this.spinner) { this.spinner.show() };
  },
  
  hideDefaultPagination: function() {
    if(this.default_pagination){ this.default_pagination.hide() };
  },
  
  distanceToBottom: function(){
    return document.body.clientHeight - document.viewport.getScrollOffsets()[1] - document.viewport.getHeight()
  },
  
  startListener: function () {
    this.timer = setTimeout(function() { this.checkScroll() }.bind(this), this.interval);
  },
  
  checkScroll: function () {
    if(this.timer == undefined || this.total_pages == this.current_page) {
      // listener was stopped or we've run out of pages
      return; 
    }

    // if slider past our scroll offset, then fire a request for more data
    if(this.distanceToBottom() < this.distance_to_bottom_offset) {
      this.current_page++; // move to next page
      this.showSpinner();
      new Ajax.Request(this.ajax_path, { method: 'get', parameters: { page: this.current_page }, onComplete: function(){ this.hideSpinner()}.bind(this) });
    }

    // start the listener again
    this.startListener();
  }
});