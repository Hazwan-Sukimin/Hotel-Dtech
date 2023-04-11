var object = { status: false, ele: null };

function sweetalertclick(ev){
    var evnt = ev;
    if (object.status) { return true; }
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire(
              'Deleted!',
              'Your file has been deleted.',
              'success'
            )
            object.status = true;
            object.ele = evnt;
            evnt.click();
        }
      })
      
      return object.status;
};
