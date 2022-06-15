package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.service.impl.BuildingService;
import com.laptrinhjavaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController(value = "buildingAPIOfAdmin")
@RequestMapping("/api")
public class BuildingAPI {

    @Autowired
    ServletContext servletContext;
    @Autowired
    private BuildingService buildingService;

    @Autowired
    private UserService userService;

    /*@PostMapping("/building")
    public BuildingDTO createBuilding(@RequestBody BuildingDTO newBuilding){
        buildingService.saveBuilding(newBuilding);
        return newBuilding;
    }*/

    @PostMapping("/building")
    public ResponseEntity<BuildingDTO> createBuilding(@RequestBody BuildingDTO newBuilding){
        return ResponseEntity.ok(buildingService.saveBuilding(newBuilding));
    }

    /*@DeleteMapping("/building")
    public void deleteBuildings(@RequestBody List<Long> ids) {
        buildingService.deleteBuilding(ids);
    }*/

    @DeleteMapping("/building")
    public ResponseEntity<Void> deleteBuildings(@RequestBody List<Long> ids) {
        buildingService.deleteBuilding(ids);
        return ResponseEntity.noContent().build();
    }


    /*@GetMapping(value = "/building/{id}")
    public BuildingDTO getBuilding(@PathVariable("id") long id) {
        BuildingDTO dto = buildingService.getBuldingById(id);
        return dto;
    }*/
    @GetMapping(value = "/building/{id}")
    public ResponseEntity<BuildingDTO> getBuilding(@PathVariable("id") long id) {
        return ResponseEntity.ok(buildingService.getBuldingById(id));
    }

    /*@GetMapping("/building/{buildingId}/staffs")
    public ResponseDTO loadStaff(@PathVariable("buildingId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return result;
    }*/

    @GetMapping("/building/{buildingId}/staffs")
    public ResponseEntity<ResponseDTO> loadStaff(@PathVariable("buildingId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return ResponseEntity.ok(result);
    }

    /*@PostMapping("/building-assignment")
    public void updateAssignmentUser(@RequestBody AssignmentBuildingRequest request){
        userService.assignmentBuilding(request);
    }*/

    @PostMapping("/building-assignment")
    public ResponseEntity<Void> updateAssignmentUser(@RequestBody AssignmentBuildingRequest request){
        userService.assignmentBuilding(request);
        return ResponseEntity.noContent().build();
    }


    @PostMapping("/building/{buildingId}")
    public ResponseEntity<String> updateAvatarCustomer(@PathVariable("buildingId") long id, @RequestPart(value = "file") MultipartFile file,
                                                       HttpServletRequest request) throws ServletException, IOException {

        String imgurl="";
        for (Part part : request.getParts()) {
            String contentDisp = part.getHeader("content-disposition");
            String[] items = contentDisp.split(";");
            for(String s : items){
                String tmp = s.trim();
                if (tmp.startsWith("filename")){
                    int idx = tmp.indexOf('=') + 2;
                    String filename = tmp.substring(idx, tmp.length() - 1);
                    String targetDir = servletContext.getRealPath("Public/Imgs/Buildings");
                    String destination = targetDir + "/" + filename;

                    part.write(destination);
                    imgurl ="/Public/Imgs/Buildings/"+ filename;

                    System.out.println(targetDir);
                    System.out.println(imgurl);
                    System.out.println(destination);
                }
            }
        }
        BuildingDTO buildingDTO = buildingService.getBuldingById(id);
        buildingDTO.setAvatar(imgurl);
        buildingService.updateBuildingAvatar(buildingDTO);

        return new ResponseEntity<>("File uploaded!!", HttpStatus.OK);
    }

}
