package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.dto.response.BuildingSearchResponse;
import com.laptrinhjavaweb.dto.response.CustomerResponse;
import com.laptrinhjavaweb.security.utils.SecurityUtils;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "buildingControllerOfAdmin")
public class BuildingController {

	@Autowired
	private IBuildingService buildingService;

	@Autowired
	private IUserService userService;

	@RequestMapping(value = "/admin/building-list", method = RequestMethod.GET)
	public ModelAndView buildingList(@ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest) {
		ModelAndView mav = new ModelAndView("admin/building/building-list");

		// check role is Staff
		if (SecurityUtils.getAuthorities().contains(SystemConstant.STAFF_ROLE)) {
			Long staffId = SecurityUtils.getPrincipal().getId();
			buildingSearchRequest.setStaffId(staffId);
		}
		List<BuildingSearchResponse> buildingSearchResponses;
		buildingSearchResponses = buildingService.findBuildingSearch(buildingSearchRequest);

		mav.addObject("modelSearch", buildingSearchRequest);
		mav.addObject("buildings", buildingSearchResponses);
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		mav.addObject("staffs", userService.findAllStaff());


		return mav;
	}

	@RequestMapping(value = "/admin/building-edit", method = RequestMethod.GET)
	public ModelAndView buildingEdit(@ModelAttribute("modelEdit") BuildingDTO buildingDTO) {
		ModelAndView mav = new ModelAndView("admin/building/building-edit");
		mav.addObject("buildingModel", new BuildingDTO());
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		return mav;
	}

	@RequestMapping(value = "/admin/building-edit-{id}", method = RequestMethod.GET)
	public ModelAndView buildingEditDetail(@PathVariable("id") long id) {
		ModelAndView mav = new ModelAndView("admin/building/building-edit");
		mav.addObject("modelEdit", buildingService.getBuldingById(id));
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		return mav;
	}

	/*@RequestMapping(value = "/admin/building-search", method = RequestMethod.GET)
	public ModelAndView buildingSearch(@ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest) {
		ModelAndView mav = new ModelAndView("admin/building/building-list");
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		mav.addObject("buildings", buildingService.findBuildingSearch(buildingSearchRequest));
		mav.addObject("staffs", userService.findAllStaff());
		mav.addObject("modelSearch", buildingSearchRequest);

		return mav;
	}*/

}
